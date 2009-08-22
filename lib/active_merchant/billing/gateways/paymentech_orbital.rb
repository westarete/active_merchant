require File.dirname(__FILE__) + '/paymentech_orbital/paymentech_orbital_constants'
require File.dirname(__FILE__) + '/paymentech_orbital/requests/paymentech_orbital_request'
require File.dirname(__FILE__) + '/paymentech_orbital/responses/paymentech_orbital_response'

module ActiveMerchant #:nodoc:  
  module Billing #:nodoc:  
    class PaymentechOrbitalGateway < Gateway
      include PaymentechConstants
      
      self.money_format           = :cents
      self.supported_countries    = ['US']
      self.supported_cardtypes    = [:visa, :master, :american_express, :discover]
      self.homepage_url           = 'http://www.chasepaymentech.com/'
      self.display_name           = 'Paymentech Orbital Gateway'
      
      class_inheritable_accessor :failover_period
      self.failover_period = DEFAULT_FAILOVER_PERIOD
      
      ### CREATION ###
      
      def initialize(options = {})
        self.merchant_id   = options[:merchant_id]
        self.terminal_id   = options[:terminal_id] || DEFAULT_TERMINAL_ID
        self.industry_type = options[:industry_type] || DEFAULT_INDUSTRY_TYPE
        self.bin           = options[:bin] || DEFAULT_BIN
        super
      end
      
      ### TRANSACTIONS ###
      
      def authorize(money, creditcard, options={})
        PaymentechAuthorizeRequest.post(self, money, creditcard, options)
      end
  
      def purchase(money, creditcard, options={})
        PaymentechPurchaseRequest.post(self, money, creditcard, options)
      end     
      alias authorize_and_capture purchase
      
      def force_capture(money, creditcard, options={})
        PaymentechForceCaptureRequest.post(self, money, creditcard, options)
      end      
      
      def refund(money, txn_reference_number, options={})
        PaymentechRefundRequest.post(self, money, txn_reference_number, options)
      end      
      alias credit refund
      
      def reversal(txn_reference_number, options={})
        PaymentechReversalRequest.post(self, txn_reference_number, options)
      end
      
      def manage_profile(options, creditcard=nil)
        PaymentechProfileRequest.post(self, options, creditcard)
      end
      
      def end_of_day
        PaymentechEodRequest.post(self)
      end
      
      def inquiry(order_id, retry_number)
        PaymentechInquiryRequest.post(self, order_id, retry_number)
      end
      
      protected
      
        attr_accessor :industry_type, :bin, :merchant_id, :terminal_id, 
                      :last_failover
        
        ### HTTP / CONNECTION MANAGEMENT ###
        
        # Enhances retry scenario to failover to secondary URLs if connections
        # cannot be obtained with the primary URLs.
        def retry_exceptions_with_failover
          retry_exceptions_without_failover { yield }
        rescue ConnectionError
          # Set the last failover time and retry connections; they should now
          # use the secondary URLs.
          self.last_failover = Time.now.utc
          retry_exceptions_without_failover
        end
        alias_method_chain :retry_exceptions, :failover
        
        def failing_over?
          return false unless last_failover
          Time.now.utc > last_failover + (DEFAULT_FAILOVER_PERIOD * 60)
        end      
    end
  end
end

