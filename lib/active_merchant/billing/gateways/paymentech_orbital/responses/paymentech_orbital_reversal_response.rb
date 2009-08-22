module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class PaymentechReversalResponse < PaymentechResponse
      
      def txn_reference_number
        @params['tx_ref_num']
      end
      alias authorization txn_reference_number
      
      def txn_reference_idx
        @params['tx_ref_idx']
      end
      
      def outstanding_amount
        Money.new(@params['outstanding_amt'].to_i, 'USD')
      end
      
    end
  end
end