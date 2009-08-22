module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    #
    # This request type allows for the following profile actions: 
    # - Add a Profile 
    # - Delete a Profile 
    # - Update a Profile 
    # - Retrieve a profile [and all its attributes] 
    #
    class PaymentechProfileRequest < PaymentechRequest
      
      def self.post(gateway, options, creditcard=nil)
        txn = new(gateway, options, creditcard)
        txn.send(:commit)
      end    

      ### PROFILE HELPERS ###         
               
      def profile_from_order
        options[:from_order_indicator] || 'EMPTY'
      end      
      
      def use_customer_ref_num?
        profile_from_order == 'S'
      end   
      
      def profile_order_override
        PROFILE_ORDER_OVERRIDES[options[:order_override]] || 'NO'
      end
      
      def profile_status
        PROFILE_STATUSES[options[:status]] || 'A'
      end
      
      def profile_action
        PROFILE_ACTIONS[options[:action]]
      end

      protected
      
        attr_accessor :creditcard, :options 

        def initialize(gateway, options, creditcard=nil)
          @request_template_name = 'profile'
          @options = options
          @creditcard = creditcard
          super(gateway)
        end
    end    
  end
end