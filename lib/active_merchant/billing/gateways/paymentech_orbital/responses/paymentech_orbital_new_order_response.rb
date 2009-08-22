module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class PaymentechNewOrderResponse < PaymentechResponse
      
      def txn_reference_number
        @params['tx_ref_num']
      end
      alias authorization txn_reference_number
      
      def txn_reference_idx
        @params['tx_ref_idx']
      end
      
      def approved?
         @params['approval_status'] == '1'
      end
      
      def declined?
        not approved?
      end
      
      def avs_response_code
        @params['avs_resp_code']
      end
      alias avs_result avs_response_code
      
      def cvv2_response_code
        @params['cvv2_resp_code']
      end    
      alias cvv_result cvv2_response_code
      
      def cavv_response_code
        @params['cavv_resp_code']
      end
      
      def auth_code
        @params['auth_code']
      end  
      
      def profile_process_status
        @params['profile_proc_status']
      end
      
      def profile_process_message
        @params['customer_profile_message']
      end
      
      def customer_reference_number
        @params['customer_ref_num']
      end
      
      protected
      
        def success_from(params)
          super && params['approval_status'] == '1'
        end
      
    end
  end
end