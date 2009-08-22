module ActiveMerchant #:nodoc:
  module Billing #:nodoc:

    class PaymentechNewOrderRequest < PaymentechRequest

      def self.post(gateway, money, creditcard, options={})
        txn = new(gateway, money, creditcard, options)
        txn.send(:commit)
      end
      
      protected
      
        attr_accessor :money, :order_id, :creditcard, :options, 
                      :txn_reference_number
        
        def initialize(gateway, money, creditcard, options={})
          @request_template_name = 'new_order'
          @money = money
          @order_id = options[:order_id]
          @creditcard = creditcard
          @options = options
          super(gateway)
        end
        
        ### CREDIT CARD HELPERS ###
        
        def verification_value
          creditcard.verification_value || ''
        end
        
        def vbv_transaction_type
          options[:vbv] && 
            VERIFIED_BY_VISA_TRANSACTION_TYPES[options[:vbv][:transaction_type]]
        end
                 
        ### ECP HELPERS ###
        
        def ecp_delivery_method
          if options[:electronic_check] && options[:electronic_check][:ach]
            'A'
          else
            'B'
          end 
        end
        
        ### PC2 HELPERS ###
        
        def tax_indicator
          options[:pc2] && options[:pc2][:tax_indicator] || '0'  
        end       
                 
        ### PROFILE HELPERS ###         
                 
        def profile_from_order
          options[:profile] && options[:profile][:from_order_indicator] || 'EMPTY'
        end      
        
        def use_customer_reference_number?
          profile_from_order == 'S'
        end   
        
        def profile_order_override
          PROFILE_ORDER_OVERRIDES[options[:profile][:order_override]] || 'NO'
        end
        
        def profile_status
          PROFILE_STATUSES[options[:profile][:status]] || 'A'
        end
                 
    end
    
    class PaymentechAuthorizeRequest < PaymentechNewOrderRequest     
 
      def message_type
        'A'
      end
 
    end    
    
    class PaymentechPurchaseRequest < PaymentechNewOrderRequest      

      def message_type
        'AC'
      end
      
    end
    
    class PaymentechForceCaptureRequest < PaymentechNewOrderRequest     

      def message_type
        'FC'
      end
       
    end
    
    class PaymentechRefundRequest < PaymentechNewOrderRequest     
       
      def self.post(gateway, money, txn_reference_number, options={})
        txn = new(gateway, money, txn_reference_number, options)
        txn.send(:commit)
      end    
      
      def message_type
        'R'
      end
      
      protected
      
        def initialize(gateway, money, txn_reference_number, options={})
          @txn_reference_number = txn_reference_number
          super(gateway, money, nil, options)
        end
      
    end        
    
  end
end