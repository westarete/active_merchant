require File.dirname(__FILE__) + '/../../test_helper'

class PaymentechOrbitalTest < Test::Unit::TestCase
  
  def setup
    @merchant_id = '4815162342'
    @terminal_id      = '001'
    @gateway = PaymentechOrbitalGateway.new(:merchant_id => @merchant_id)
    @money            = Money.new(10000, 'USD')
    @credit_card      = credit_card    
    @order_id         = '1234'
    @reference_number = '9876'
    @batch_seq_number = '1234567890'
    @retry_number     = '123'
    @error_message    = "error message"
    @response_code    = '22'
    @options          = {:order_id => @order_id}
  end
  
  ### NEW ORDER :: AUTHORIZE_AND_CAPTURE (PURCHASE) ###
  
  def test_should_approve_purchase
    @gateway.expects(:ssl_post).returns(approved_purchase_response)
    response = @gateway.purchase(@money, @credit_card, @options)
    assert_success response
    assert_merchant_response(response)
  end
  
  def test_should_decline_purchase
    @gateway.expects(:ssl_post).returns(declined_purchase_response)
    response = @gateway.purchase(@money, @credit_card, @options)
    assert_failure response
    assert_merchant_response(response)
    assert_response_code(response)
  end  
  
  ### NEW ORDER :: REFUND ###
  
  def test_should_approve_refund
    @gateway.expects(:ssl_post).returns(approved_refund_response)
    response = @gateway.refund(@money, @reference_number, @options)
    assert_success response
    assert_merchant_response(response)
    assert_refund_response(response)
  end  
  
  def test_should_reject_refund
    @gateway.expects(:ssl_post).returns(declined_refund_response)
    response = @gateway.refund(@money, @reference_number, @options)
    assert_failure response
    assert_merchant_response(response)
    assert_response_code(response)
  end  
  
  ### REVERSAL ###
  
  def test_should_approve_reversal
    @gateway.expects(:ssl_post).returns(approved_reversal_response)
    response = @gateway.reversal(@reference_number, @options)
    assert_success response
    assert_merchant_response(response)
    assert_reversal_response(response)
  end

  def test_should_decline_reversal
    @gateway.expects(:ssl_post).returns(declined_reversal_response)
    response = @gateway.reversal(@reference_number, @options)
    assert_failure response
    assert_merchant_response(response)
    assert_reversal_response(response)
    assert_error_message(response)
  end
  
  ### END OF DAY ###
  
  def test_should_accept_end_of_day
    @gateway.expects(:ssl_post).returns(successful_end_of_day_response)
    response = @gateway.end_of_day
    assert_success response
    assert_merchant_response(response)
    assert_equal @batch_seq_number, response.params['batch_seq_num']
  end

  def test_should_reject_end_of_day
    @gateway.expects(:ssl_post).returns(failed_end_of_day_response)
    response = @gateway.end_of_day
    assert_failure response
    assert_merchant_response(response)
    assert_error_message(response)
  end  
  
  ### INQUIRY ###
  
  def test_should_accept_inquiry
    @gateway.expects(:ssl_post).returns(successful_inquiry_response)
    response = @gateway.inquiry(@order_id, @retry_number)
    assert_success response
    assert_merchant_response(response)
  end

  def test_should_reject_inquiry
    @gateway.expects(:ssl_post).returns(failed_inquiry_response)
    response = @gateway.inquiry(@order_id, @retry_number)
    assert_failure response
    assert_merchant_response(response)
    assert_error_message(response)
  end

  private
  
    ### TEST HELPERS ###
  
    def assert_merchant_response(response)
      assert_equal @merchant_id, response.params['merchant_id']
      assert_equal @terminal_id, response.params['terminal_id']      
    end
    
    def assert_reversal_response(response)
      assert_equal @order_id, response.params['order_id']
      assert_equal @reference_number, response.params['tx_ref_num']
      assert_equal(@error_message, response.message) unless response.success?
      assert(response.message.blank?) if response.success?
    end
    
    def assert_refund_response(response)
      assert_equal @reference_number, response.params['tx_ref_num']
    end
    
    def assert_error_message(response)
      assert_equal @error_message, response.params['status_msg']
    end
    
    def assert_response_code(response)
      assert_equal @response_code, response.params['resp_code']
    end    
    
    ### NEW ORDER :: AUTHORIZE_AND_CAPTURE (PURCHASE) ###
    
    def approved_purchase_response
      return <<-XML
        <?xml version="1.0" encoding="UTF-8"?>  
        <Response>
          <NewOrderResp> 
            <IndustryType/> 
            <MessageType>AC</MessageType> 
            <MerchantID>#{@merchant_id}</MerchantID> 
            <TerminalID>#{@terminal_id}</TerminalID>
            <CardBrand>MC</CardBrand> 
            <AccountNum>5454545454545454</AccountNum> 
            <OrderID>8316384413</OrderID> 
            <TxRefNum>48E0E5BC6EAB75C4863A09DFED9804E7EC2E54A1</TxRefNum> 
            <TxRefIdx>1</TxRefIdx> 
            <ProcStatus>0</ProcStatus> 
            <ApprovalStatus>1</ApprovalStatus> 
            <RespCode>00</RespCode> 
            <AVSRespCode>H </AVSRespCode> 
            <CVV2RespCode> </CVV2RespCode> 
            <AuthCode>191044</AuthCode> 
            <RecurringAdviceCd/> 
            <CAVVRespCode/>
            <StatusMsg>Approved</StatusMsg> 
            <RespMsg/> 
            <HostRespCode>00</HostRespCode> 
            <HostAVSRespCode>Y</HostAVSRespCode> 
            <HostCVV2RespCode/> 
            <CustomerRefNum/> 
            <CustomerName/> 
            <ProfileProcStatus/> 
            <CustomerProfileMessage/> 
            <RespTime>102708</RespTime> 
          </NewOrderResp> 
        </Response>
      XML
    end    
    
    def declined_purchase_response
      return <<-XML
        <?xml version="1.0" encoding="UTF-8"?>  
        <Response>
          <NewOrderResp> 
            <IndustryType/> 
            <MessageType>AC</MessageType> 
            <MerchantID>#{@merchant_id}</MerchantID> 
            <TerminalID>#{@terminal_id}</TerminalID>
            <CardBrand>MC</CardBrand> 
            <AccountNum>5454545454545454</AccountNum> 
            <OrderID>8316384413</OrderID> 
            <TxRefNum>48E0E5BC6EAB75C4863A09DFED9804E7EC2E54A1</TxRefNum> 
            <TxRefIdx>1</TxRefIdx> 
            <ProcStatus>1</ProcStatus> 
            <ApprovalStatus>0</ApprovalStatus> 
            <RespCode>#{@response_code}</RespCode> 
            <AVSRespCode>H </AVSRespCode> 
            <CVV2RespCode> </CVV2RespCode> 
            <AuthCode>191044</AuthCode> 
            <RecurringAdviceCd/> 
            <CAVVRespCode/>
            <StatusMsg>Approved</StatusMsg> 
            <RespMsg/> 
            <HostRespCode>00</HostRespCode> 
            <HostAVSRespCode>Y</HostAVSRespCode> 
            <HostCVV2RespCode/> 
            <CustomerRefNum/> 
            <CustomerName/> 
            <ProfileProcStatus/> 
            <CustomerProfileMessage/> 
            <RespTime>102708</RespTime> 
          </NewOrderResp> 
        </Response>
      XML
    end    
    
    ### NEW ORDER :: REFUND ###
    
    def approved_refund_response
      return <<-XML
        <?xml version="1.0" encoding="UTF-8"?>  
        <Response>
          <NewOrderResp> 
            <IndustryType/> 
            <MessageType>AC</MessageType> 
            <MerchantID>#{@merchant_id}</MerchantID> 
            <TerminalID>#{@terminal_id}</TerminalID>
            <TxRefNum>#{@reference_number}</TxRefNum> 
            <ProcStatus>0</ProcStatus> 
            <ApprovalStatus>1</ApprovalStatus> 
            <RespCode>00</RespCode> 
            <RespTime>102708</RespTime> 
          </NewOrderResp> 
        </Response>
      XML
    end
  
    def declined_refund_response
      return <<-XML
        <?xml version="1.0" encoding="UTF-8"?>  
        <Response>
          <NewOrderResp> 
            <IndustryType/> 
            <MessageType>AC</MessageType> 
            <MerchantID>#{@merchant_id}</MerchantID> 
            <TerminalID>#{@terminal_id}</TerminalID>
            <TxRefNum>#{@reference_number}</TxRefNum> 
            <ProcStatus>1</ProcStatus> 
            <StatusMsg>#{@error_message}</StatusMsg> 
            <ApprovalStatus>0</ApprovalStatus> 
            <RespCode>#{@response_code}</RespCode> 
            <RespTime>102708</RespTime> 
          </NewOrderResp> 
        </Response>
      XML
    end     
    
    ### REVERSAL ###
    
    def approved_reversal_response
      return <<-XML
        <?xml version="1.0" encoding="UTF-8"?>  
        <Response> 
          <ReversalResp> 
            <MerchantID>#{@merchant_id}</MerchantID> 
            <TerminalID>#{@terminal_id}</TerminalID>          
            <OrderID>#{@order_id}</OrderID>
            <TxRefNum>#{@reference_number}</TxRefNum>
            <ProcStatus>0</ProcStatus> 
            <RespTime>102708</RespTime> 
          </ReversalResp> 
        </Response>
      XML
    end
    
    def declined_reversal_response
      return <<-XML
        <?xml version="1.0" encoding="UTF-8"?>  
        <Response> 
          <ReversalResp> 
            <MerchantID>#{@merchant_id}</MerchantID> 
            <TerminalID>#{@terminal_id}</TerminalID>          
            <OrderID>#{@order_id}</OrderID>
            <TxRefNum>#{@reference_number}</TxRefNum>
            <ProcStatus>1</ProcStatus> 
            <StatusMsg>#{@error_message}</StatusMsg> 
            <RespTime>102708</RespTime> 
          </ReversalResp> 
        </Response>
      XML
    end
    
    ### END OF DAY ###

    def successful_end_of_day_response
      return <<-XML
        <?xml version="1.0" encoding="UTF-8"?>  
        <Response> 
          <EndOfDayResp> 
            <MerchantID>#{@merchant_id}</MerchantID> 
            <TerminalID>#{@terminal_id}</TerminalID>          
            <BatchSeqNum>#{@batch_seq_number}</BatchSeqNum>
            <ProcStatus>0</ProcStatus> 
            <RespTime>102708</RespTime> 
          </EndOfDayResp> 
        </Response>
      XML
    end
    
    def failed_end_of_day_response
      return <<-XML
        <?xml version="1.0" encoding="UTF-8"?>  
        <Response> 
          <EndOfDayResp> 
            <MerchantID>#{@merchant_id}</MerchantID> 
            <TerminalID>#{@terminal_id}</TerminalID>          
            <BatchSeqNum>#{@batch_seq_number}</BatchSeqNum>
            <ProcStatus>1</ProcStatus> 
            <StatusMsg>#{@error_message}</StatusMsg> 
            <RespTime>102708</RespTime> 
          </EndOfDayResp> 
        </Response>
      XML
    end
    
    ### INQUIRY ###

    def successful_inquiry_response
      return <<-XML
        <?xml version="1.0" encoding="UTF-8"?>  
        <Response> 
          <EndOfDayResp> 
            <MerchantID>#{@merchant_id}</MerchantID> 
            <TerminalID>#{@terminal_id}</TerminalID>          
            <ProcStatus>0</ProcStatus> 
            <RespTime>102708</RespTime> 
          </EndOfDayResp> 
        </Response>
      XML
    end
    
    def failed_inquiry_response
      return <<-XML
        <?xml version="1.0" encoding="UTF-8"?>  
        <Response> 
          <EndOfDayResp> 
            <MerchantID>#{@merchant_id}</MerchantID> 
            <TerminalID>#{@terminal_id}</TerminalID>        
            <ProcStatus>1</ProcStatus> 
            <StatusMsg>#{@error_message}</StatusMsg> 
            <RespTime>102708</RespTime> 
          </EndOfDayResp> 
        </Response>
      XML
    end    
    
    ### PROFILE ###
    
    def successful_add_profile_response
      return <<-XML    
        <?xml version="1.0" encoding="UTF-8"?> 
        <Response> 
          <ProfileResp> 
            <CustomerBin>000001</CustomerBin> 
            <CustomerMerchantID>#{@merchant_id}</CustomerMerchantID> 
            <CustomerName>JON DOE</CustomerName> 
            <CustomerRefNum>ADDPROFILE 123</CustomerRefNum> 
            <CustomerProfileAction>CREATE</CustomerProfileAction> 
            <ProfileProcStatus>0</ProfileProcStatus> 
            <CustomerProfileMessage>Profile Request Processed</CustomerProfileMessage> 
            <CustomerAddress1>123 TEST DRIVE</CustomerAddress1> 
            <CustomerAddress2>SUITE 123</CustomerAddress2> 
            <CustomerCity>TEST CITY</CustomerCity> 
            <CustomerState>FL</CustomerState> 
            <CustomerZIP>33626</CustomerZIP> 
            <CustomerEmail>jondoe@test.com</CustomerEmail> 
            <CustomerPhone>2232231234</CustomerPhone> 
            <CustomerCountryCode>US</CustomerCountryCode> 
            <CustomerProfileOrderOverrideInd>NO</CustomerProfileOrderOverrideInd> 
            <OrderDefaultDescription>Sample Order Description</OrderDefaultDescription> 
            <OrderDefaultAmount>1500</OrderDefaultAmount> 
            <CustomerAccountType>CC</CustomerAccountType> 
            <Status>A</Status> 
            <CCAccountNum>5454545454545454</CCAccountNum> 
            <CCExpireDate>0810</CCExpireDate> 
            <ECPAccountDDA/> 
            <ECPAccountType/> 
            <ECPAccountRT/> 
            <ECPBankPmtDlv/> 
            <SwitchSoloStartDate/> 
            <SwitchSoloIssueNum/> 
            <MBType>R</MBType> 
            <MBOrderIdGenerationMethod>IO</MBOrderIdGenerationMethod> 
            <MBRecurringStartDate>12092008</MBRecurringStartDate> 
            <MBRecurringNoEndDateFlag>Y</MBRecurringNoEndDateFlag> 
            <MBRecurringFrequency>00000205W</MBRecurringFrequency> 
            <RespTime/> 
          </ProfileResp> 
        </Response>
      XML
    end
    
end
