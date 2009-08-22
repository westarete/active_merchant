module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    #
    # An “End of Day” request/response instructs the gateway to submit all 
    # transactions previously marked for capture [including all successful 
    # refunds] for clearing.
    #
    class PaymentechEodRequest < PaymentechRequest
      
      def self.post(gateway)
        txn = new(gateway)
        txn.send(:commit)
      end    

      private

        def initialize(gateway)
          @request_template_name = 'eod'
          super(gateway)
        end
      
    end
  end
end