require File.dirname(__FILE__) + '/../../test_helper'

class OrbitalPaymentechTest < Test::Unit::TestCase
  AMOUNT = 100

  def setup
    @gateway = OrbitalPaymentechGateway.new(
      :routing_id => '000001',
      :merchant_id => '054321',
      :terminal_id => '001',
      :login => 'login',
      :password => 'password',
      :test => true
    )

    @creditcard = credit_card('4242424242424242')

    @address = { 
      :address1 => '1234 My Street',
      :address2 => 'Apt 1',
      :company => 'Widgets Inc',
      :city => 'Ottawa',
      :state => 'ON',
      :zip => 'K1C2N6',
      :country => 'CA',
      :phone => '(555)555-5555'
    }

    @options = {
      :address => @address,
      :email => 'someguy1232@fakeemail.net',
      :order_id => 'test1111111111111111',
      :currency => 'USD',
      :description => "Test Transaction"      
    }
  end
  
  def test_length_of_merchant_id_for_bin_1
    assert_nothing_raised do
      OrbitalPaymentechGateway.new(
        :routing_id => '000001',
        :merchant_id => '054321',   # 6 digits
        :terminal_id => '001',
        :login => 'login',
        :password => 'password',
        :test => true
      )
    end
    assert_raise ArgumentError do
      OrbitalPaymentechGateway.new(
        :routing_id => '000001',
        :merchant_id => '05432',    # 5 digits
        :terminal_id => '001',
        :login => 'login',
        :password => 'password',
        :test => true
      )
    end
    assert_raise ArgumentError do
      OrbitalPaymentechGateway.new(
        :routing_id => '000001',
        :merchant_id => '0543210',  # 7 digits
        :terminal_id => '001',
        :login => 'login',
        :password => 'password',
        :test => true
      )
    end
  end
  
  def test_length_of_merchant_id_for_bin_2
    assert_nothing_raised do
      OrbitalPaymentechGateway.new(
        :routing_id => '000002',
        :merchant_id => '054321054321',   # 12 digits
        :terminal_id => '001',
        :login => 'login',
        :password => 'password',
        :test => true
      )
    end
    assert_raise ArgumentError do
      OrbitalPaymentechGateway.new(
        :routing_id => '000002',
        :merchant_id => '05432105432',    # 11 digits
        :terminal_id => '001',
        :login => 'login',
        :password => 'password',
        :test => true
      )
    end
    assert_raise ArgumentError do
      OrbitalPaymentechGateway.new(
        :routing_id => '000002',
        :merchant_id => '0543210543210',  # 13 digits
        :terminal_id => '001',
        :login => 'login',
        :password => 'password',
        :test => true
      )
    end
  end
    
  def test_successful_auth
    elem = NewOrderResponseElement.new
    elem.txRefNum = '12345'
    elem.txRefIdx = '0'
    elem.respCode = '00'
    elem.respCodeMessage = "Authorized"
    elem.respDateTime = '20080101121200'
    elem.avsRespCode = 'H'
    elem.cvvRespCode = 'M'
    elem.procStatus = '0'
    elem.approvalStatus = '1'
    PaymentechGatewayPortType.any_instance.stubs(:init_methods) # keep newOrder from being overwritten at runtime
    PaymentechGatewayPortType.any_instance.stubs(:newOrder).returns(NewOrderResponse.new(elem))
    
    assert response = @gateway.authorize(AMOUNT, @creditcard, @options)
    assert_success response
    assert_equal '12345', response.authorization
    assert response.test?
  end

  def test_unsuccessful_purchase
    elem = NewOrderResponseElement.new
    elem.txRefNum = '12345'
    elem.txRefIdx = '0'
    elem.respCode = '00'
    elem.respCodeMessage = "Authorized"
    elem.respDateTime = '20080101121200'
    elem.avsRespCode = 'H'
    elem.cvvRespCode = 'M'
    elem.procStatus = '0'
    elem.approvalStatus = '0'
    PaymentechGatewayPortType.any_instance.stubs(:init_methods) # keep newOrder from being overwritten at runtime
    PaymentechGatewayPortType.any_instance.stubs(:newOrder).returns(NewOrderResponse.new(elem))

    assert response = @gateway.purchase(AMOUNT, @creditcard, @options)
    assert_failure response
    assert response.test?
  end

  def test_successful_capture
    elem = MarkForCaptureResponseElement.new
    elem.txRefNum = '12345'
    elem.txRefIdx = '0'
    elem.splitTxRefIdx = '0'
    elem.procStatus = '0'
    elem.procStatusMessage = 'Sample Proc Status Message'
    elem.respDateTime = '20080101121200'
    elem.amount = '1.23'
    PaymentechGatewayPortType.any_instance.stubs(:init_methods) # keep newOrder from being overwritten at runtime
    PaymentechGatewayPortType.any_instance.stubs(:markForCapture).returns(MarkForCaptureResponse.new(elem))
    
    assert response = @gateway.capture(AMOUNT, '12345', @options)
    assert response.test?
   end

  def test_successful_reversal
    elem = ReversalResponseElement.new
    elem.txRefNum = '12345'
    elem.txRefIdx = '0'
    elem.procStatus = '0'
    elem.procStatusMessage = 'Sample Proc Status Message'
    elem.respDateTime = '20080101121200'
    elem.outstandingAmt = '0'
    PaymentechGatewayPortType.any_instance.stubs(:init_methods) # keep newOrder from being overwritten at runtime
    PaymentechGatewayPortType.any_instance.stubs(:reversal).returns(ReversalResponse.new(elem))
    
    assert response = @gateway.void('12345', @options.merge({:transaction_ref_index => '1'}))
    assert response.test?
   end
   
   def test_presence_indicator
     # It should include ccCardVerifyNum and ccCardVerifyPresenceInd if card
     # is a visa and cvv is present.
     cc = credit_card('4242424242424242', :type => 'visa', :verification_value => '123')
     request_element = NewOrderRequestElement.new
     @gateway.send(:add_creditcard, request_element, cc)
     assert_equal '123', request_element.ccCardVerifyNum
     assert_equal 1, request_element.ccCardVerifyPresenceInd

     # It should NOT include ccCardVerifyPresenceInd if card
     # is a visa and cvv is not present.
     cc = credit_card('4242424242424242', :type => 'visa', :verification_value => nil)
     request_element = NewOrderRequestElement.new
     @gateway.send(:add_creditcard, request_element, cc)
     assert_nil request_element.ccCardVerifyNum
     assert_nil request_element.ccCardVerifyPresenceInd

     # It should NOT include ccCardVerifyPresenceInd if card
     # is a mastercard and cvv IS present. But SHOULD send the CVV itself.
     cc = credit_card('5454545454545454', :type => 'mastercard', :verification_value => '333')
     request_element = NewOrderRequestElement.new
     @gateway.send(:add_creditcard, request_element, cc)
     assert_equal '333', request_element.ccCardVerifyNum
     assert_nil request_element.ccCardVerifyPresenceInd
   end


end
