module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class PaymentechProfileResponse < PaymentechResponse
       
      def profile_process_status
        @params['profile_proc_status']
      end
      
      def profile_success?
        profile_process_status == '0'
      end
      
      def profile_process_message
        @params['customer_profile_message']
      end
      
      def customer_reference_number
        @params['customer_ref_num']
      end
      
    end
  end
end