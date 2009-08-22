module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class PaymentechEodResponse < PaymentechResponse
      
      def batch_sequence_number
        @params['batch_seq_num']
      end
      
    end
  end
end