module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    #
    # This request is for voiding a previous transaction either in the full 
    # amount or partial.  If a Reversal (void) request is sent for a partial 
    # amount, the transaction will be split into two components. A voided 
    # transaction in the amount of the partial void request and the remainder 
    # of the previous transaction in the same state the full amount was 
    # previously in [Authorized or Marked for Capture].
    #
    class PaymentechReversalRequest < PaymentechRequest
      # PARAMETERS
      #
      # order_id
      # - The value of the order from the transaction being reversed.
      #
      # txn_reference_number 
      # - A reference to the transaction to be reversed; so, must capture this
      #   value on previous transactions that are reversable.
      # 
      # options (hash):
      #   :txn_reference_idx
      #   - Only used for subsequent adjustments; so, must capture and maintain
      #     and send previous reference with each subsequent adjustment. 
      #   :adjusted_amount 
      #   - Only used for partial amount reversals; should be no more than
      #     original transaction amount.
      #   :retry_number
      #   - Provide the retry trace number from the transaction that needs to 
      #     be voided in the event the txn_reference_number is not known.
      #    
      def self.post(gateway, txn_reference_number, options={})
        txn = new(gateway, txn_reference_number, options)
        txn.send(:commit)
      end    
    
      private
        
        attr_accessor :order_id, :txn_reference_number, :options

        def initialize(gateway, txn_reference_number, options={})
          @request_template_name = 'reversal'
          @order_id = options[:order_id]
          @txn_reference_number = txn_reference_number
          @options = options
          super(gateway)
        end     
    end
  end
end