require File.dirname(__FILE__) + '/../../test_helper'

class RemotePaymentechOrbitalTest < Test::Unit::TestCase
  
  # Set to true to run exhaustive set of tests to ensure response codes are
  # returned and verified.
  VERIFY_RESPONSE_CODES    = false
  
  VISA                     = '4444444444444448'
  VISA_COMMERCIAL_CARD     = '4444424444444440'
  VISA_CORPORATE_CARD_II   = '4444414444444441'
  VISA_PURCHASING_CARD_III = '4055011111111111'
  MASTERCARD               = '5454545454545454'
  MASTERCARD_2             = '5500005555555559'
  MASTERCARD_3             = '5555555555555557'
  MASTERCARD_II            = '5555515555555551'
  MASTERCARD_III           = '5405222222222226'
  MASTERCARD_III_2         = '5478050000000007'
  MASTERCARD_DINERS        = '36111111111111'
  AMEX                     = '371449635398431'
  AMEX_2                   = '343434343434343'
  DISCOVER                 = '6011000995500000'
  DISCOVER_2               = '6500000000000002'
  DINERS                   = '36438999960016'
  JCB                      = '3566002020140006'
  
  
  def setup
    @gateway = PaymentechOrbitalGateway.new(fixtures(:paymentech_orbital))
    @money                = Money.new(10000, 'USD')
    @visa_card            = credit_card(VISA)
    @visa_card_commercial = credit_card(VISA_COMMERCIAL_CARD)
    @visa_card_corporate  = credit_card(VISA_CORPORATE_CARD_II)
    @visa_card_purchasing = credit_card(VISA_PURCHASING_CARD_III)
    @mastercard           = credit_card(MASTERCARD)
    @mastercard_ii        = credit_card(MASTERCARD_II)
    @mastercard_iii       = credit_card(MASTERCARD_III)
    @mastercard_diners    = credit_card(MASTERCARD_DINERS)
    @amex             = credit_card(AMEX)
    @discover         = credit_card(DISCOVER)
    @declined_card    = credit_card('4000300011112220')
    @reference_number = '123456'
    @order_id         = '12345'
    @retry_number     = 1
  end
  
  ### AUTHORIZE ###
    
  # ---( Visa )  
    
  if VERIFY_RESPONSE_CODES  
    def test_should_match_expected_response_code_for_visa_authorize
      VISA_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.authorize(Money.new(amount.to_i, 'USD'), @visa_card, :order_id => "1")
        assert_equal VISA_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end    
  
    def test_should_match_expected_response_code_for_visa_commercial_authorize
      VISA_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.authorize(Money.new(amount.to_i, 'USD'), @visa_card_commercial, :order_id => "1")
        assert_equal VISA_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end  
  
    def test_should_match_expected_response_code_for_visa_corporate_authorize
      VISA_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.authorize(Money.new(amount.to_i, 'USD'), @visa_card_corporate, :order_id => "1")
        assert_equal VISA_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end  
  
    def test_should_match_expected_response_code_for_visa_purchasing_authorize
      VISA_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.authorize(Money.new(amount.to_i, 'USD'), @visa_card_purchasing, :order_id => "1")
        assert_equal VISA_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end
  end  
  
  # ---( Mastercard )
    
  if VERIFY_RESPONSE_CODES  
    def test_should_match_expected_response_code_for_mastercard_authorize
      MASTERCARD_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.authorize(Money.new(amount.to_i, 'USD'), @mastercard, :order_id => "1")
        assert_equal MASTERCARD_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end
  
    def test_should_match_expected_response_code_for_mastercard_ii_authorize
      MASTERCARD_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.authorize(Money.new(amount.to_i, 'USD'), @mastercard_ii, :order_id => "1")
        assert_equal MASTERCARD_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end  
  
    def test_should_match_expected_response_code_for_mastercard_iii_authorize
      MASTERCARD_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.authorize(Money.new(amount.to_i, 'USD'), @mastercard_iii, :order_id => "1")
        assert_equal MASTERCARD_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end  
  
    def test_should_match_expected_response_code_for_mastercard_diners_authorize
      MASTERCARD_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.authorize(Money.new(amount.to_i, 'USD'), @mastercard_diners, :order_id => "1")
        assert_equal MASTERCARD_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end
  end
  
  # ---( AMEX )
  
  if VERIFY_RESPONSE_CODES
    def test_should_match_expected_response_code_for_amex_authorize
      AMEX_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.authorize(Money.new(amount.to_i, 'USD'), @amex, :order_id => "1")
        assert_equal AMEX_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end  
  end
  
  # ---( DISCOVER )
  
  if VERIFY_RESPONSE_CODES
    def test_should_match_expected_response_code_for_discover_authorize
      DISCOVER_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.authorize(Money.new(amount.to_i, 'USD'), @discover, :order_id => "1")
        assert_equal DISCOVER_AMOUNT_TO_CODE_MAP[amount], response.response_code
      end
    end  
  end
  
  ### AUTHORIZE AND CAPTURE (PURCHASE) ###
  
  # ---( Scenarios )
  
  def test_should_decline_purchase
    amount = Money.new(001, 'USD')
    assert response = @gateway.purchase(amount, @declined_card, :order_id => "1")
    assert response.declined?
  end  
  
  def test_should_approve_purchase
    amount = Money.new(001, 'USD')
    assert response = @gateway.purchase(amount, @mastercard, :order_id => "1")
    assert_equal '00', response.response_code
    assert_not_nil response.txn_reference_number
    assert response.approved?
  end
  
  def test_should_approve_purchase_and_save_customer_profile
    options = {
      :order_id => "1",
      :profile => {
        :status => :active,
        :order_override => :use_for_order,
        :from_order_indicator => 'A'
      }
    }
    amount = Money.new(001, 'USD')
    assert response = @gateway.purchase(amount, @mastercard, options)
    assert_equal '00', response.response_code
    assert_not_nil response.txn_reference_number
    assert response.approved?
    customer_reference_number = response.customer_reference_number
    options = {
      :action => :retrieve,
      :status => :active,
      :from_order_indicator => 'A',
      :customer_reference_number => customer_reference_number
    }  
    assert response = @gateway.manage_profile(options)
    assert response.profile_success?    
    assert_equal @mastercard.number, response.params['cc_account_num']    
  end  
  
  # ---( Visa )  
    
  if VERIFY_RESPONSE_CODES
    def test_should_match_expected_response_code_for_visa_purchase
      VISA_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.purchase(Money.new(amount.to_i, 'USD'), @visa_card, :order_id => "1")
        assert_equal VISA_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end    
  
    def test_should_match_expected_response_code_for_visa_commercial_purchase
      VISA_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.purchase(Money.new(amount.to_i, 'USD'), @visa_card_commercial, :order_id => "1")
        assert_equal VISA_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end  
  
    def test_should_match_expected_response_code_for_visa_corporate_purchase
      VISA_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.purchase(Money.new(amount.to_i, 'USD'), @visa_card_corporate, :order_id => "1")
        assert_equal VISA_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end  
  
    def test_should_match_expected_response_code_for_visa_purchasing_purchase
      VISA_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.purchase(Money.new(amount.to_i, 'USD'), @visa_card_purchasing, :order_id => "1")
        assert_equal VISA_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end 
  end 
  
  # ---( Mastercard )
  
  if VERIFY_RESPONSE_CODES
    def test_should_match_expected_response_code_for_mastercard_purchase
      MASTERCARD_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.purchase(Money.new(amount.to_i, 'USD'), @mastercard, :order_id => "1")
        assert_equal MASTERCARD_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end
  
    def test_should_match_expected_response_code_for_mastercard_ii_purchase
      MASTERCARD_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.purchase(Money.new(amount.to_i, 'USD'), @mastercard_ii, :order_id => "1")
        assert_equal MASTERCARD_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end  
  
    def test_should_match_expected_response_code_for_mastercard_iii_purchase
      MASTERCARD_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.purchase(Money.new(amount.to_i, 'USD'), @mastercard_iii, :order_id => "1")
        assert_equal MASTERCARD_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end  
  
    def test_should_match_expected_response_code_for_mastercard_diners_purchase
      MASTERCARD_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.purchase(Money.new(amount.to_i, 'USD'), @mastercard_diners, :order_id => "1")
        assert_equal MASTERCARD_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end  
  end
  
  # ---( AMEX )
  
  if VERIFY_RESPONSE_CODES
    def test_should_match_expected_response_code_for_amex_purchase
      AMEX_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.purchase(Money.new(amount.to_i, 'USD'), @amex, :order_id => "1")
        assert_equal AMEX_AMOUNT_TO_CODE_MAP[amount], 
                     response.response_code
      end
    end 
  end 
  
  # ---( DISCOVER )
  
  if VERIFY_RESPONSE_CODES
    def test_should_match_expected_response_code_for_discover_purchase
      DISCOVER_AMOUNT_TO_CODE_MAP.keys.sort.each do |amount|
        assert response = 
          @gateway.purchase(Money.new(amount.to_i, 'USD'), @discover, :order_id => "1")
        assert_equal DISCOVER_AMOUNT_TO_CODE_MAP[amount], response.response_code
      end
    end  
  end
  
  ### REFUND ###
  
  def test_should_refund_for_mastercard
    amount = Money.new(001, 'USD')
    assert response = @gateway.purchase(amount, @mastercard, :order_id => "1")
    assert_equal '00', response.response_code
    tx_ref_num = response.txn_reference_number
    assert response = @gateway.refund(amount, tx_ref_num, :order_id => "1")
    assert_success response
  end  
  
  def test_should_partially_refund_for_mastercard
    amount = Money.new(10000, 'USD')
    assert response = @gateway.purchase(amount, @mastercard, :order_id => "1")
    assert response.approved?
    tx_ref_num = response.txn_reference_number
    amount = Money.new(6500, 'USD')
    assert response = @gateway.refund(amount, tx_ref_num, :order_id => "1")
    assert_success response
  end
  
  def test_should_decline_refund_overage_for_mastercard
    amount = Money.new(500, 'USD')
    assert response = @gateway.purchase(amount, @mastercard, :order_id => "1")
    assert response.approved?
    tx_ref_num = response.txn_reference_number
    amount = Money.new(1000, 'USD')
    assert response = @gateway.refund(amount, tx_ref_num, :order_id => "1")
    assert_failure response
  end
  
  ### AUTHENTICATION ###
  
  def test_invalid_authentication
    gateway = PaymentechOrbitalGateway.new
    assert response = gateway.end_of_day
    assert_failure response
  end  
  
  ### REVERSAL ###
  
  def test_successful_reversal
    assert response = @gateway.authorize(Money.new(001, 'USD'), @mastercard, :order_id => "1")
    assert response.approved?
    txn_reference_number = response.txn_reference_number
    assert response = @gateway.reversal(txn_reference_number, :order_id => "1")
    assert_success response
  end
  
  def test_successful_partial_reversal
    amount = Money.new(10000, 'USD')
    assert response = @gateway.authorize(amount, @visa_card, :order_id => "1")
    assert response.approved?
    txn_reference_number = response.txn_reference_number
    options = { :adjusted_amount => 7500, :order_id => "1" }
    assert response = @gateway.reversal(txn_reference_number, options)
    assert_success response
    assert_equal Money.new(2500, 'USD'), response.outstanding_amount
  end
  
  def test_should_decline_reversal_overage
    amount = Money.new(7500, 'USD')
    assert response = @gateway.authorize(amount, @visa_card, :order_id => "1")
    assert response.approved?
    txn_reference_number = response.txn_reference_number
    options = { :adjusted_amount => 10000, :order_id => "1" }
    assert response = @gateway.reversal(txn_reference_number, options)
    assert_failure response
  end
  
  ### END OF DAY ###
  
  def test_successful_end_of_day
    assert response = @gateway.end_of_day
    assert_success response
    assert_equal '', response.message
    assert_not_nil response.batch_sequence_number
  end
  
  ### INQUIRY ###
  
  def test_successful_inquiry
    assert response = @gateway.inquiry(@order_id, @retry_number)
    assert_success response
  end  
  
  ### PROFILE ###
  
  def test_should_add_and_retrieve_customer_profile
    options = {
      :action => :create,
      :status => :active,
      :order_override => :use_none,
      :from_order_indicator => 'A'
    }
    assert response = @gateway.manage_profile(options, @mastercard)
    assert response.profile_success?
    customer_reference_number = response.customer_reference_number
    options = {
      :action => :retrieve,
      :status => :active,
      :from_order_indicator => 'A',
      :customer_reference_number => customer_reference_number
    }  
    assert response = @gateway.manage_profile(options)
    assert response.profile_success?
    assert_equal @mastercard.number, response.params['cc_account_num']    
  end
  
  def test_should_add_and_delete_customer_profile
    options = {
      :action => :create,
      :status => :active,
      :order_override => :use_none,
      :from_order_indicator => 'A'
    }
    assert response = @gateway.manage_profile(options, @mastercard)
    assert response.profile_success?
    customer_reference_number = response.customer_reference_number
    options = {
      :action => :delete,
      :status => :active,
      :from_order_indicator => 'A',
      :customer_reference_number => customer_reference_number
    }  
    assert response = @gateway.manage_profile(options)
    assert response.profile_success?
    options = {
      :action => :retrieve,
      :status => :active,
      :from_order_indicator => 'A',
      :customer_reference_number => customer_reference_number
    }  
    assert response = @gateway.manage_profile(options)
    assert_false response.profile_success?    
  end  
  
  def test_should_add_and_update_customer_profile
    options = {
      :action => :create,
      :status => :active,
      :order_override => :use_none,
      :from_order_indicator => 'A'
    }
    assert response = @gateway.manage_profile(options, @mastercard)
    assert response.profile_success?
    customer_reference_number = response.customer_reference_number
    options = {
      :action => :update,
      :status => :active,
      :from_order_indicator => 'A',
      :customer_reference_number => customer_reference_number
    }  
    assert response = @gateway.manage_profile(options, @visa_card)
    assert response.profile_success?
    options = {
      :action => :retrieve,
      :status => :active,
      :from_order_indicator => 'A',
      :customer_reference_number => customer_reference_number
    }  
    assert response = @gateway.manage_profile(options)
    assert response.profile_success?    
    assert_equal @visa_card.number, response.params['cc_account_num'] 
  end  
  
  def test_should_add_customer_profile_and_purchase_from_profile
    options = {
      :action => :create,
      :status => :active,
      :order_override => :use_for_order,
      :from_order_indicator => 'A'
    }
    assert response = @gateway.manage_profile(options, @mastercard)
    assert response.profile_success?
    customer_reference_number = response.customer_reference_number
    options = {
      :order_id => "1",
      :profile => {
        :customer_reference_number => customer_reference_number
      }
    }
    amount = Money.new(10000, 'USD')
    assert response = @gateway.purchase(amount, nil, options)
    assert_equal '00', response.response_code
    assert_not_nil response.txn_reference_number
    assert response.approved?
    assert_equal @mastercard.number, response.params['account_num']    
  end
  
  ### CONSTANTS ###

  VISA_AMOUNT_TO_CODE_MAP = {
    '10000' => '00',
    '20100' => '68',
    '20400' => '66',
    '24900' => 'BR',
    '25300' => 'B1',
    '25700' => '00',
    '30100' => '98',
    '30200' => '89',
    '30300' => '52',
    '30400' => 'B5',
    '40100' => '01',
    '40200' => '10',
    '50100' => '04',
    '50200' => '41',
    '50300' => '00',
    '50800' => 'C3',
    '50900' => 'C4',
    '51000' => 'C5',
    '52100' => 'D7',
    '52200' => '33',
    '53000' => '05',
    '53100' => '64',
#    '57000' => 'G4',    # 07
#    '57100' => 'G5',    # 09
#    '57200' => 'F3',    # PB
    '59100' => '14',
    '59200' => '13',
    '59400' => '06',
    '59500' => 'BS',
    '59600' => 'BQ',
    '60200' => '72',
    '60300' => 'E4',
    '60500' => '74',
    '60600' => '12',
    '60700' => '77',
#    '75400' => 'BK',    # F3
    '80200' => '50',
    '80600' => '56',
    '81100' => '00',
    '81300' => 'H9',
    '82500' => '71',
    '83300' => '79',
    '90200' => 'L2',
#    '90300' => '00',    # L3
    '90400' => 'L4',
    '99900' => '99'   
  }  

  MASTERCARD_AMOUNT_TO_CODE_MAP = {
    '10000' => '00',
    '20100' => '68',
    '20400' => '66',
    '24900' => 'BR',
    '25300' => 'B1',
#    '25700' => 'BP',   # 00
    '30100' => '98',
    '30200' => '89',
    '30300' => '52',
    '30400' => 'B5',
    '40100' => '01',
    '40200' => '10',
    '50100' => '04',
    '50200' => '41',
    '50300' => '00',
    '50800' => 'C3',
    '50900' => 'C4',
    '51000' => 'C5',
    '52100' => 'D7',
    '52200' => '33',
    '53000' => '05',
    '53100' => '64',
#    '57000' => 'G4',   # 07
#    '57100' => 'G5',   # 09
    '57200' => '00',
    '59100' => '14',
    '59200' => '13',
    '59400' => '06',
    '59500' => 'BS',
    '59600' => 'BQ',
    '60200' => '72',
    '60300' => 'E4',
    '60500' => '74',
    '60600' => '12',
    '60700' => '77',
#    '75400' => 'BK',   # L3
    '80200' => '50',
    '80600' => '56',
    '81100' => '00',
    '81300' => 'H9',
    '82500' => '71',
    '83300' => '79',
    '90200' => 'L2',
#    '90300' => '00',   # L3
    '90400' => 'L4',
    '99900' => '99'   
  }

  AMEX_AMOUNT_TO_CODE_MAP = {
    '10000' => '00',
    '20100' => '68',
    '20400' => '66',
    '24900' => 'BR',
    '25300' => 'B1',
    '25700' => '00',
    '30100' => '98',
    '30200' => '89',
    '30300' => '52',
    '30400' => 'B5',
    '40100' => '01',
    '40200' => '10',
    '50100' => '04',
    '50200' => '00',
    '50300' => '00',
    '50800' => 'C3',
    '50900' => 'C4',
    '51000' => 'C5',
    '52100' => 'D7',
    '52200' => '33',
    '53000' => '05',
    '53100' => '00',
#    '57000' => 'G4',   # 07
#    '57100' => 'G5',   # 09
    '57200' => '00',
    '59100' => '14',
    '59200' => '13',
    '59400' => '06',
    '59500' => 'BS',
    '59600' => 'BQ',
    '60200' => '72',
    '60300' => 'E4',
    '60500' => '74',
    '60600' => '00',
    '60700' => '77',
#    '75400' => 'BK',   # F3
    '80200' => '50',
    '80600' => '56',
    '81100' => '65',
    '81300' => 'H9',
    '82500' => '00',
    '83300' => '79',
    '90200' => 'L2',
#    '90300' => '00',   # L3
    '90400' => 'L4',
    '99900' => '99'   
  }  

  DISCOVER_AMOUNT_TO_CODE_MAP = {
    '10000' => '00',
    '20100' => '68',
    '20400' => '66',
    '24900' => 'BR',
    '25300' => 'B1',
    '25700' => '00',
    '30100' => '98',
    '30200' => '89',
    '30300' => '52',
    '30400' => 'B5',
    '40100' => '01',
    '40200' => '10',
    '50100' => '04',
    '50200' => '41',
    '50300' => 'B7',
    '50800' => 'C3',
    '50900' => 'C4',
    '51000' => 'C5',
    '52100' => 'D7',
    '52200' => '33',
    '53000' => '05',
    '53100' => '00',
#    '57000' => 'G4',   # 07
#    '57100' => 'G5',   # 09
#    '57200' => 'F3',   # PB
    '59100' => '14',
    '59200' => '13',
    '59400' => '06',
    '59500' => 'BS',
    '59600' => 'BQ',
    '60200' => '72',
    '60300' => 'E4',
    '60500' => '74',
    '60600' => '12',
    '60700' => '77',
#    '75400' => 'BK',   # F3
    '80200' => '50',
    '80600' => '56',
    '81100' => '00',
    '81300' => 'H9',
    '82500' => '71',
    '83300' => '79',
    '90200' => 'L2',
    '90300' => 'L3',
    '90400' => 'L4',
    '99900' => '99'   
  }

end
