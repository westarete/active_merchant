require 'erb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class PaymentechOrbitalGateway < Gateway; end

    class PaymentechRequest < DelegateClass(PaymentechOrbitalGateway)
      
      PRIMARY_CERTIFICATION_URL   = 'https://orbitalvar1.paymentech.net/authorize'
      SECONDARY_CERTIFICATION_URL = 'https://orbitalvar2.paymentech.net/authorize'
      PRIMARY_PRODUCTION_URL      = 'https://orbital1.paymentech.net/authorize'
      SECONDARY_PRODUCTION_URL    = 'https://orbital2.paymentech.net/authorize'
          
      CurrencyCode = Struct.new(:code, :exponent)
      
      CURRENCY_CODES = { 
        "AUD"=> CurrencyCode.new('036', 2),
        "CAD"=> CurrencyCode.new('124', 2),
        "GBP"=> CurrencyCode.new('826', 2),
        "USD"=> CurrencyCode.new('840', 2),
        "EUR"=> CurrencyCode.new('978', 2)
      }       
      
      COUNTRIES = %w(US CA GB UK)
      
      CARD_BRAND = {
        :visa => 'VI',
        :mastercard => 'MC',
        :discover => '',
        :american_express => '',
        :diners_club => '',
        :jcb => '',
        :switch => 'SW',
        :solo => '',
        :dankort => '',
        :maestro => '',
        :forbrugsforeningen => '',
        :laser => '',
        :european_direct_debit => 'ED',
        :electronic_check => 'EC',
        :bill_me_later => 'BL',
        :pinless_debit => 'DP'
      }
      
      PROFILE_ACTIONS = {
        :create => 'C',
        :update => 'U',
        :delete => 'D',
        :retrieve => 'R'
      }
      
      PROFILE_ORDER_OVERRIDES = {
        :use_none => 'NO',
        :use_for_order => 'OI',
        :use_for_comments => 'OD',
        :use_for_order_and_comments => 'OA'
      }
      
      PROFILE_STATUSES = {
        :active => 'A',
        :inactive => 'I',
        :suspend => 'MS'
      }
      
      VERIFIED_BY_VISA_TRANSACTION_TYPES = {
        :authenticated_transaction => '5',
        :attempted_authentication => '6'
      }      
      
      SUCCESS_RESPONSE_CODES = %w(00 08 11 24 26 28 29 31 32 34 E7 PA )          
          
      protected
      
        attr_accessor :request_template_name, :request_template
      
        def commit
          xml = request_template.result(binding())
          xml_response = ssl_post(url, xml, headers(xml.length))
          return PaymentechResponse.create(xml_response, test?)
        end

        def request_template
          @request_template ||= 
            ERB.new(File.read(File.dirname(__FILE__) + 
                    "/templates/#{request_template_name}.erb"))
        end

        def headers(content_length, retry_number=nil)
          return_headers = {
            "MIME-Version" => "1.0",
            "Content-Type" => "application/PTI45",
            "Content-Length" => content_length.to_s,
            "Content-transfer-encoding" => "text",
            "Request-number" => "1",
            "Document-type" => "Request",
            "Interface-Version" => 'Ruby|ActiveMerchant|Proprietary Gateway'
          }
          if retry_number
            return_headers.merge('Trace-number' => "#{retry_number}") 
          end
          return_headers
       	end      

        def url
          unless failing_over?
            test? && PRIMARY_CERTIFICATION_URL || PRIMARY_PRODUCTION_URL
          else
            test? && SECONDARY_CERTIFICATION_URL || SECONDARY_PRODUCTION_URL
          end
        end     
        
        def country_for(country)
          country = country && country.upcase
          COUNTRIES.include?(country) ? country : ''
        end
        
        def card_expiration_for(creditcard)
          return '' unless creditcard.month && creditcard.year
          format(creditcard.month, :two_digits) + format(creditcard.year, :two_digits)
        end
        
        def card_verification_indicator_for(creditcard, options)
          if creditcard.verification_value
            '1'
          else
            options && options[:verification_indicator] || '9'
          end               
        end
    
        def card_brand_for(creditcard)
          CARD_BRAND[creditcard.type] || ''
        end        
    end
  end 
end

require File.dirname(__FILE__) + '/paymentech_orbital_eod_request'
require File.dirname(__FILE__) + '/paymentech_orbital_inquiry_request'
require File.dirname(__FILE__) + '/paymentech_orbital_reversal_request'
require File.dirname(__FILE__) + '/paymentech_orbital_new_order_request'
require File.dirname(__FILE__) + '/paymentech_orbital_profile_request'