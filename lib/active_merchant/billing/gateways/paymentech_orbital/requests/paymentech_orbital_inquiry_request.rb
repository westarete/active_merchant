module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    # 
    # An Inquiry request returns the response of any specified request.  This 
    # is useful when a merchant needs to know the result of a transaction in 
    # the case of, for example, a communication error.  A retry_number value 
    # of the originating transaction must be passed in the Inquiry request 
    # message in order to obtain the response.  If there is no matching 
    # result, an error message is returned.
    #
    class PaymentechInquiryRequest < PaymentechRequest
      # PARAMETERS
      #      
      # order_id
      # - Use the same order_id as the original request.
      #
      # retry_number
      # - Provide the retry_number from the original request to return the 
      #   original response.  If the original transaction was not processed 
      #   successfully, the Gateway will return an error message.
      #
      def self.post(gateway, order_id, retry_number)
        txn = new(gateway, order_id, retry_number)
        txn.send(:commit)
      end    

      private

        attr_accessor :order_id, :retry_number

        def initialize(gateway, order_id, retry_number)
          @request_template_name = 'inquiry'
          @order_id = order_id
          @retry_number = retry_number
          super(gateway)
        end
    end
  end
end