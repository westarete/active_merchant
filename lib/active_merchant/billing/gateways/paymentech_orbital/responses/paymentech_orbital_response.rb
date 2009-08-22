module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class PaymentechResponse < Response

      ### CREATION ###

      def self.create(xml_response, is_test)
        full_response_hash = parse_element(REXML::Document.new(xml_response))
        response_type = full_response_hash['response'].keys.first
        response_hash = full_response_hash['response'].values.first
        case response_type
          when "end_of_day_resp" then PaymentechEodResponse.new(response_hash, is_test)
          when "reversal_resp" then PaymentechReversalResponse.new(response_hash, is_test)
          when "new_order_resp" then PaymentechNewOrderResponse.new(response_hash, is_test)
          when "profile_resp" then PaymentechProfileResponse.new(response_hash, is_test)
        else
          new(response_hash, is_test)
        end
      end

      def process_status
        @params['proc_status']
      end
      
      def process_status_message
        @params['status_msg']
      end

      def response_code
        @params['resp_code']
      end      
      
      def response_message
        @params['resp_msg']
      end

      private

        def initialize(params, is_test)
          success = success_from(params)
          message = message_from(params)
          super(success, message, params, :test => is_test)
        end
      
      protected
      
        def success_from(params)
          params['proc_status'] == '0'
        end
      
        def message_from(params)
          params['status_msg'] || ''
        end
      
        def self.parse_element(element)
          if element.has_elements?
            options = {}
            element.elements.each do |child_element|
              key = child_element.name.underscore
              value = parse_element(child_element)
              if options.has_key?(key)
                if options[key].is_a?(Array)
                  options[key].push(value)
                else
                  options[key] = [options[key], value]
                end
              else
                options[key] = parse_element(child_element) 
              end 
            end
          else
            options = element.text
          end
          options          
        end
    end
  end
end

require File.dirname(__FILE__) + '/paymentech_orbital_eod_response'
require File.dirname(__FILE__) + '/paymentech_orbital_reversal_response'
require File.dirname(__FILE__) + '/paymentech_orbital_new_order_response'
require File.dirname(__FILE__) + '/paymentech_orbital_profile_response'