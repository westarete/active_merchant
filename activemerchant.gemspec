# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{activemerchant}
  s.version = "1.4.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tobias Luetke", "Cody Fauser", "Scott Woods"]
  s.date = %q{2010-05-11}
  s.description = %q{Active Merchant is a simple payment abstraction library used in and sponsored by Shopify. It is written by Tobias Luetke, Cody Fauser, and contributors. The aim of the project is to feel natural to Ruby users and to abstract as many parts as possible away from the user to offer a consistent interface across all supported gateways. This is a patched version that includes unofficial support for the Chase Paymentech Orbital gateway.}
  s.email = %q{scott@westarete.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG",
     "CONTRIBUTERS",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "activemerchant.gemspec",
     "gem-public_cert.pem",
     "generators/gateway/USAGE",
     "generators/gateway/gateway_generator.rb",
     "generators/gateway/templates/gateway.rb",
     "generators/gateway/templates/gateway_test.rb",
     "generators/gateway/templates/remote_gateway_test.rb",
     "generators/integration/USAGE",
     "generators/integration/integration_generator.rb",
     "generators/integration/templates/helper.rb",
     "generators/integration/templates/helper_test.rb",
     "generators/integration/templates/integration.rb",
     "generators/integration/templates/module_test.rb",
     "generators/integration/templates/notification.rb",
     "generators/integration/templates/notification_test.rb",
     "init.rb",
     "lib/active_merchant.rb",
     "lib/active_merchant/billing/avs_result.rb",
     "lib/active_merchant/billing/base.rb",
     "lib/active_merchant/billing/check.rb",
     "lib/active_merchant/billing/credit_card.rb",
     "lib/active_merchant/billing/credit_card_formatting.rb",
     "lib/active_merchant/billing/credit_card_methods.rb",
     "lib/active_merchant/billing/cvv_result.rb",
     "lib/active_merchant/billing/expiry_date.rb",
     "lib/active_merchant/billing/gateway.rb",
     "lib/active_merchant/billing/gateways.rb",
     "lib/active_merchant/billing/gateways/authorize_net.rb",
     "lib/active_merchant/billing/gateways/authorize_net_cim.rb",
     "lib/active_merchant/billing/gateways/beanstream.rb",
     "lib/active_merchant/billing/gateways/beanstream/beanstream_core.rb",
     "lib/active_merchant/billing/gateways/beanstream_interac.rb",
     "lib/active_merchant/billing/gateways/bogus.rb",
     "lib/active_merchant/billing/gateways/braintree.rb",
     "lib/active_merchant/billing/gateways/card_stream.rb",
     "lib/active_merchant/billing/gateways/cyber_source.rb",
     "lib/active_merchant/billing/gateways/data_cash.rb",
     "lib/active_merchant/billing/gateways/efsnet.rb",
     "lib/active_merchant/billing/gateways/elavon.rb",
     "lib/active_merchant/billing/gateways/eway.rb",
     "lib/active_merchant/billing/gateways/exact.rb",
     "lib/active_merchant/billing/gateways/first_pay.rb",
     "lib/active_merchant/billing/gateways/instapay.rb",
     "lib/active_merchant/billing/gateways/linkpoint.rb",
     "lib/active_merchant/billing/gateways/merchant_e_solutions.rb",
     "lib/active_merchant/billing/gateways/merchant_ware.rb",
     "lib/active_merchant/billing/gateways/modern_payments.rb",
     "lib/active_merchant/billing/gateways/modern_payments_cim.rb",
     "lib/active_merchant/billing/gateways/moneris.rb",
     "lib/active_merchant/billing/gateways/net_registry.rb",
     "lib/active_merchant/billing/gateways/netbilling.rb",
     "lib/active_merchant/billing/gateways/ogone.rb",
     "lib/active_merchant/billing/gateways/orbital_paymentech.rb",
     "lib/active_merchant/billing/gateways/orbital_paymentech/PaymentechGateway.prod.wsdl",
     "lib/active_merchant/billing/gateways/orbital_paymentech/PaymentechGateway.rb",
     "lib/active_merchant/billing/gateways/orbital_paymentech/PaymentechGateway.var.wsdl",
     "lib/active_merchant/billing/gateways/orbital_paymentech/PaymentechGatewayConstants.rb",
     "lib/active_merchant/billing/gateways/orbital_paymentech/PaymentechGatewayDriver.rb",
     "lib/active_merchant/billing/gateways/orbital_paymentech/PaymentechGatewayMappingRegistry.rb",
     "lib/active_merchant/billing/gateways/pay_junction.rb",
     "lib/active_merchant/billing/gateways/pay_secure.rb",
     "lib/active_merchant/billing/gateways/payflow.rb",
     "lib/active_merchant/billing/gateways/payflow/payflow_common_api.rb",
     "lib/active_merchant/billing/gateways/payflow/payflow_express_response.rb",
     "lib/active_merchant/billing/gateways/payflow/payflow_response.rb",
     "lib/active_merchant/billing/gateways/payflow_express.rb",
     "lib/active_merchant/billing/gateways/payflow_express_uk.rb",
     "lib/active_merchant/billing/gateways/payflow_uk.rb",
     "lib/active_merchant/billing/gateways/payment_express.rb",
     "lib/active_merchant/billing/gateways/paypal.rb",
     "lib/active_merchant/billing/gateways/paypal/paypal_common_api.rb",
     "lib/active_merchant/billing/gateways/paypal/paypal_express_response.rb",
     "lib/active_merchant/billing/gateways/paypal_ca.rb",
     "lib/active_merchant/billing/gateways/paypal_express.rb",
     "lib/active_merchant/billing/gateways/paypal_express_common.rb",
     "lib/active_merchant/billing/gateways/plugnpay.rb",
     "lib/active_merchant/billing/gateways/psigate.rb",
     "lib/active_merchant/billing/gateways/psl_card.rb",
     "lib/active_merchant/billing/gateways/quickpay.rb",
     "lib/active_merchant/billing/gateways/realex.rb",
     "lib/active_merchant/billing/gateways/sage.rb",
     "lib/active_merchant/billing/gateways/sage/sage_bankcard.rb",
     "lib/active_merchant/billing/gateways/sage/sage_core.rb",
     "lib/active_merchant/billing/gateways/sage/sage_virtual_check.rb",
     "lib/active_merchant/billing/gateways/sage_pay.rb",
     "lib/active_merchant/billing/gateways/secure_pay.rb",
     "lib/active_merchant/billing/gateways/secure_pay_au.rb",
     "lib/active_merchant/billing/gateways/secure_pay_tech.rb",
     "lib/active_merchant/billing/gateways/skip_jack.rb",
     "lib/active_merchant/billing/gateways/smart_ps.rb",
     "lib/active_merchant/billing/gateways/trans_first.rb",
     "lib/active_merchant/billing/gateways/transax.rb",
     "lib/active_merchant/billing/gateways/trust_commerce.rb",
     "lib/active_merchant/billing/gateways/usa_epay.rb",
     "lib/active_merchant/billing/gateways/verifi.rb",
     "lib/active_merchant/billing/gateways/viaklix.rb",
     "lib/active_merchant/billing/gateways/wirecard.rb",
     "lib/active_merchant/billing/integrations.rb",
     "lib/active_merchant/billing/integrations/action_view_helper.rb",
     "lib/active_merchant/billing/integrations/bogus.rb",
     "lib/active_merchant/billing/integrations/bogus/helper.rb",
     "lib/active_merchant/billing/integrations/bogus/notification.rb",
     "lib/active_merchant/billing/integrations/bogus/return.rb",
     "lib/active_merchant/billing/integrations/chronopay.rb",
     "lib/active_merchant/billing/integrations/chronopay/helper.rb",
     "lib/active_merchant/billing/integrations/chronopay/notification.rb",
     "lib/active_merchant/billing/integrations/chronopay/return.rb",
     "lib/active_merchant/billing/integrations/gestpay.rb",
     "lib/active_merchant/billing/integrations/gestpay/common.rb",
     "lib/active_merchant/billing/integrations/gestpay/helper.rb",
     "lib/active_merchant/billing/integrations/gestpay/notification.rb",
     "lib/active_merchant/billing/integrations/gestpay/return.rb",
     "lib/active_merchant/billing/integrations/helper.rb",
     "lib/active_merchant/billing/integrations/hi_trust.rb",
     "lib/active_merchant/billing/integrations/hi_trust/helper.rb",
     "lib/active_merchant/billing/integrations/hi_trust/notification.rb",
     "lib/active_merchant/billing/integrations/hi_trust/return.rb",
     "lib/active_merchant/billing/integrations/nochex.rb",
     "lib/active_merchant/billing/integrations/nochex/helper.rb",
     "lib/active_merchant/billing/integrations/nochex/notification.rb",
     "lib/active_merchant/billing/integrations/nochex/return.rb",
     "lib/active_merchant/billing/integrations/notification.rb",
     "lib/active_merchant/billing/integrations/paypal.rb",
     "lib/active_merchant/billing/integrations/paypal/helper.rb",
     "lib/active_merchant/billing/integrations/paypal/notification.rb",
     "lib/active_merchant/billing/integrations/paypal/return.rb",
     "lib/active_merchant/billing/integrations/quickpay.rb",
     "lib/active_merchant/billing/integrations/quickpay/helper.rb",
     "lib/active_merchant/billing/integrations/quickpay/notification.rb",
     "lib/active_merchant/billing/integrations/return.rb",
     "lib/active_merchant/billing/integrations/two_checkout.rb",
     "lib/active_merchant/billing/integrations/two_checkout/helper.rb",
     "lib/active_merchant/billing/integrations/two_checkout/notification.rb",
     "lib/active_merchant/billing/integrations/two_checkout/return.rb",
     "lib/active_merchant/billing/response.rb",
     "lib/active_merchant/lib/connection.rb",
     "lib/active_merchant/lib/country.rb",
     "lib/active_merchant/lib/error.rb",
     "lib/active_merchant/lib/post_data.rb",
     "lib/active_merchant/lib/posts_data.rb",
     "lib/active_merchant/lib/requires_parameters.rb",
     "lib/active_merchant/lib/utils.rb",
     "lib/active_merchant/lib/validateable.rb",
     "lib/certs/cacert.pem",
     "lib/support/gateway_support.rb",
     "script/destroy",
     "script/generate",
     "test/fixtures.yml",
     "test/remote/gateways/remote_authorize_net_cim_test.rb",
     "test/remote/gateways/remote_authorize_net_test.rb",
     "test/remote/gateways/remote_beanstream_interac_test.rb",
     "test/remote/gateways/remote_beanstream_test.rb",
     "test/remote/gateways/remote_braintree_test.rb",
     "test/remote/gateways/remote_card_stream_test.rb",
     "test/remote/gateways/remote_cyber_source_test.rb",
     "test/remote/gateways/remote_data_cash_test.rb",
     "test/remote/gateways/remote_efsnet_test.rb",
     "test/remote/gateways/remote_elavon_test.rb",
     "test/remote/gateways/remote_eway_test.rb",
     "test/remote/gateways/remote_exact_test.rb",
     "test/remote/gateways/remote_first_pay_test.rb",
     "test/remote/gateways/remote_instapay_test.rb",
     "test/remote/gateways/remote_linkpoint_test.rb",
     "test/remote/gateways/remote_merchant_e_solutions_test.rb",
     "test/remote/gateways/remote_merchant_ware_test.rb",
     "test/remote/gateways/remote_modern_payments_cim_test.rb",
     "test/remote/gateways/remote_modern_payments_test.rb",
     "test/remote/gateways/remote_moneris_test.rb",
     "test/remote/gateways/remote_net_registry_test.rb",
     "test/remote/gateways/remote_netbilling_test.rb",
     "test/remote/gateways/remote_ogone_test.rb",
     "test/remote/gateways/remote_orbital_paymentech_test.rb",
     "test/remote/gateways/remote_pay_junction_test.rb",
     "test/remote/gateways/remote_pay_secure_test.rb",
     "test/remote/gateways/remote_payflow_express_test.rb",
     "test/remote/gateways/remote_payflow_test.rb",
     "test/remote/gateways/remote_payflow_uk_test.rb",
     "test/remote/gateways/remote_payment_express_test.rb",
     "test/remote/gateways/remote_paypal_express_test.rb",
     "test/remote/gateways/remote_paypal_test.rb",
     "test/remote/gateways/remote_plugnpay_test.rb",
     "test/remote/gateways/remote_psigate_test.rb",
     "test/remote/gateways/remote_psl_card_test.rb",
     "test/remote/gateways/remote_quickpay_test.rb",
     "test/remote/gateways/remote_realex_test.rb",
     "test/remote/gateways/remote_sage_bankcard_test.rb",
     "test/remote/gateways/remote_sage_pay_test.rb",
     "test/remote/gateways/remote_sage_test.rb",
     "test/remote/gateways/remote_sage_virtual_check_test.rb",
     "test/remote/gateways/remote_secure_pay_au_test.rb",
     "test/remote/gateways/remote_secure_pay_tech_test.rb",
     "test/remote/gateways/remote_secure_pay_test.rb",
     "test/remote/gateways/remote_skipjack_test.rb",
     "test/remote/gateways/remote_trans_first_test.rb",
     "test/remote/gateways/remote_transax_test.rb",
     "test/remote/gateways/remote_trust_commerce_test.rb",
     "test/remote/gateways/remote_usa_epay_test.rb",
     "test/remote/gateways/remote_verifi_test.rb",
     "test/remote/gateways/remote_viaklix_test.rb",
     "test/remote/gateways/remote_wirecard_test.rb",
     "test/remote/integrations/remote_gestpay_integration_test.rb",
     "test/remote/integrations/remote_paypal_integration_test.rb",
     "test/test_helper.rb",
     "test/unit/avs_result_test.rb",
     "test/unit/base_test.rb",
     "test/unit/check_test.rb",
     "test/unit/connection_test.rb",
     "test/unit/country_code_test.rb",
     "test/unit/country_test.rb",
     "test/unit/credit_card_formatting_test.rb",
     "test/unit/credit_card_methods_test.rb",
     "test/unit/credit_card_test.rb",
     "test/unit/cvv_result_test.rb",
     "test/unit/expiry_date_test.rb",
     "test/unit/gateways/authorize_net_cim_test.rb",
     "test/unit/gateways/authorize_net_test.rb",
     "test/unit/gateways/beanstream_interac_test.rb",
     "test/unit/gateways/beanstream_test.rb",
     "test/unit/gateways/bogus_test.rb",
     "test/unit/gateways/braintree_test.rb",
     "test/unit/gateways/card_stream_test.rb",
     "test/unit/gateways/cyber_source_test.rb",
     "test/unit/gateways/data_cash_test.rb",
     "test/unit/gateways/efsnet_test.rb",
     "test/unit/gateways/elavon_test.rb",
     "test/unit/gateways/eway_test.rb",
     "test/unit/gateways/exact_test.rb",
     "test/unit/gateways/first_pay_test.rb",
     "test/unit/gateways/gateway_test.rb",
     "test/unit/gateways/instapay_test.rb",
     "test/unit/gateways/linkpoint_test.rb",
     "test/unit/gateways/merchant_e_solutions_test.rb",
     "test/unit/gateways/merchant_ware_test.rb",
     "test/unit/gateways/modern_payments_cim_test.rb",
     "test/unit/gateways/moneris_test.rb",
     "test/unit/gateways/net_registry_test.rb",
     "test/unit/gateways/netbilling_test.rb",
     "test/unit/gateways/ogone_test.rb",
     "test/unit/gateways/orbital_paymentech_test.rb",
     "test/unit/gateways/pay_junction_test.rb",
     "test/unit/gateways/pay_secure_test.rb",
     "test/unit/gateways/payflow_express_test.rb",
     "test/unit/gateways/payflow_express_uk_test.rb",
     "test/unit/gateways/payflow_test.rb",
     "test/unit/gateways/payflow_uk_test.rb",
     "test/unit/gateways/payment_express_test.rb",
     "test/unit/gateways/paypal_express_test.rb",
     "test/unit/gateways/paypal_test.rb",
     "test/unit/gateways/plugnpay_test.rb",
     "test/unit/gateways/psigate_test.rb",
     "test/unit/gateways/psl_card_test.rb",
     "test/unit/gateways/quickpay_test.rb",
     "test/unit/gateways/realex_test.rb",
     "test/unit/gateways/sage_bankcard_test.rb",
     "test/unit/gateways/sage_pay_test.rb",
     "test/unit/gateways/sage_virtual_check_test.rb",
     "test/unit/gateways/secure_pay_au_test.rb",
     "test/unit/gateways/secure_pay_tech_test.rb",
     "test/unit/gateways/secure_pay_test.rb",
     "test/unit/gateways/skip_jack_test.rb",
     "test/unit/gateways/trans_first_test.rb",
     "test/unit/gateways/trust_commerce_test.rb",
     "test/unit/gateways/usa_epay_test.rb",
     "test/unit/gateways/verifi_test.rb",
     "test/unit/gateways/viaklix_test.rb",
     "test/unit/gateways/wirecard_test.rb",
     "test/unit/generators/test_gateway_generator.rb",
     "test/unit/generators/test_generator_helper.rb",
     "test/unit/generators/test_integration_generator.rb",
     "test/unit/integrations/action_view_helper_test.rb",
     "test/unit/integrations/bogus_module_test.rb",
     "test/unit/integrations/chronopay_module_test.rb",
     "test/unit/integrations/gestpay_module_test.rb",
     "test/unit/integrations/helpers/bogus_helper_test.rb",
     "test/unit/integrations/helpers/chronopay_helper_test.rb",
     "test/unit/integrations/helpers/gestpay_helper_test.rb",
     "test/unit/integrations/helpers/hi_trust_helper_test.rb",
     "test/unit/integrations/helpers/nochex_helper_test.rb",
     "test/unit/integrations/helpers/paypal_helper_test.rb",
     "test/unit/integrations/helpers/quickpay_helper_test.rb",
     "test/unit/integrations/helpers/two_checkout_helper_test.rb",
     "test/unit/integrations/hi_trust_module_test.rb",
     "test/unit/integrations/nochex_module_test.rb",
     "test/unit/integrations/notifications/chronopay_notification_test.rb",
     "test/unit/integrations/notifications/gestpay_notification_test.rb",
     "test/unit/integrations/notifications/hi_trust_notification_test.rb",
     "test/unit/integrations/notifications/nochex_notification_test.rb",
     "test/unit/integrations/notifications/notification_test.rb",
     "test/unit/integrations/notifications/paypal_notification_test.rb",
     "test/unit/integrations/notifications/quickpay_notification_test.rb",
     "test/unit/integrations/notifications/two_checkout_notification_test.rb",
     "test/unit/integrations/paypal_module_test.rb",
     "test/unit/integrations/quickpay_module_test.rb",
     "test/unit/integrations/returns/chronopay_return_test.rb",
     "test/unit/integrations/returns/gestpay_return_test.rb",
     "test/unit/integrations/returns/hi_trust_return_test.rb",
     "test/unit/integrations/returns/nochex_return_test.rb",
     "test/unit/integrations/returns/paypal_return_test.rb",
     "test/unit/integrations/returns/return_test.rb",
     "test/unit/integrations/returns/two_checkout_return_test.rb",
     "test/unit/integrations/two_checkout_module_test.rb",
     "test/unit/post_data_test.rb",
     "test/unit/posts_data_test.rb",
     "test/unit/response_test.rb",
     "test/unit/utils_test.rb",
     "test/unit/validateable_test.rb"
  ]
  s.homepage = %q{http://activemerchant.org}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Framework and tools for dealing with credit card transactions.}
  s.test_files = [
    "test/remote/gateways/remote_authorize_net_cim_test.rb",
     "test/remote/gateways/remote_authorize_net_test.rb",
     "test/remote/gateways/remote_beanstream_interac_test.rb",
     "test/remote/gateways/remote_beanstream_test.rb",
     "test/remote/gateways/remote_braintree_test.rb",
     "test/remote/gateways/remote_card_stream_test.rb",
     "test/remote/gateways/remote_cyber_source_test.rb",
     "test/remote/gateways/remote_data_cash_test.rb",
     "test/remote/gateways/remote_efsnet_test.rb",
     "test/remote/gateways/remote_elavon_test.rb",
     "test/remote/gateways/remote_eway_test.rb",
     "test/remote/gateways/remote_exact_test.rb",
     "test/remote/gateways/remote_first_pay_test.rb",
     "test/remote/gateways/remote_instapay_test.rb",
     "test/remote/gateways/remote_linkpoint_test.rb",
     "test/remote/gateways/remote_merchant_e_solutions_test.rb",
     "test/remote/gateways/remote_merchant_ware_test.rb",
     "test/remote/gateways/remote_modern_payments_cim_test.rb",
     "test/remote/gateways/remote_modern_payments_test.rb",
     "test/remote/gateways/remote_moneris_test.rb",
     "test/remote/gateways/remote_net_registry_test.rb",
     "test/remote/gateways/remote_netbilling_test.rb",
     "test/remote/gateways/remote_ogone_test.rb",
     "test/remote/gateways/remote_orbital_paymentech_test.rb",
     "test/remote/gateways/remote_pay_junction_test.rb",
     "test/remote/gateways/remote_pay_secure_test.rb",
     "test/remote/gateways/remote_payflow_express_test.rb",
     "test/remote/gateways/remote_payflow_test.rb",
     "test/remote/gateways/remote_payflow_uk_test.rb",
     "test/remote/gateways/remote_payment_express_test.rb",
     "test/remote/gateways/remote_paypal_express_test.rb",
     "test/remote/gateways/remote_paypal_test.rb",
     "test/remote/gateways/remote_plugnpay_test.rb",
     "test/remote/gateways/remote_psigate_test.rb",
     "test/remote/gateways/remote_psl_card_test.rb",
     "test/remote/gateways/remote_quickpay_test.rb",
     "test/remote/gateways/remote_realex_test.rb",
     "test/remote/gateways/remote_sage_bankcard_test.rb",
     "test/remote/gateways/remote_sage_pay_test.rb",
     "test/remote/gateways/remote_sage_test.rb",
     "test/remote/gateways/remote_sage_virtual_check_test.rb",
     "test/remote/gateways/remote_secure_pay_au_test.rb",
     "test/remote/gateways/remote_secure_pay_tech_test.rb",
     "test/remote/gateways/remote_secure_pay_test.rb",
     "test/remote/gateways/remote_skipjack_test.rb",
     "test/remote/gateways/remote_trans_first_test.rb",
     "test/remote/gateways/remote_transax_test.rb",
     "test/remote/gateways/remote_trust_commerce_test.rb",
     "test/remote/gateways/remote_usa_epay_test.rb",
     "test/remote/gateways/remote_verifi_test.rb",
     "test/remote/gateways/remote_viaklix_test.rb",
     "test/remote/gateways/remote_wirecard_test.rb",
     "test/remote/integrations/remote_gestpay_integration_test.rb",
     "test/remote/integrations/remote_paypal_integration_test.rb",
     "test/test_helper.rb",
     "test/unit/avs_result_test.rb",
     "test/unit/base_test.rb",
     "test/unit/check_test.rb",
     "test/unit/connection_test.rb",
     "test/unit/country_code_test.rb",
     "test/unit/country_test.rb",
     "test/unit/credit_card_formatting_test.rb",
     "test/unit/credit_card_methods_test.rb",
     "test/unit/credit_card_test.rb",
     "test/unit/cvv_result_test.rb",
     "test/unit/expiry_date_test.rb",
     "test/unit/gateways/authorize_net_cim_test.rb",
     "test/unit/gateways/authorize_net_test.rb",
     "test/unit/gateways/beanstream_interac_test.rb",
     "test/unit/gateways/beanstream_test.rb",
     "test/unit/gateways/bogus_test.rb",
     "test/unit/gateways/braintree_test.rb",
     "test/unit/gateways/card_stream_test.rb",
     "test/unit/gateways/cyber_source_test.rb",
     "test/unit/gateways/data_cash_test.rb",
     "test/unit/gateways/efsnet_test.rb",
     "test/unit/gateways/elavon_test.rb",
     "test/unit/gateways/eway_test.rb",
     "test/unit/gateways/exact_test.rb",
     "test/unit/gateways/first_pay_test.rb",
     "test/unit/gateways/gateway_test.rb",
     "test/unit/gateways/instapay_test.rb",
     "test/unit/gateways/linkpoint_test.rb",
     "test/unit/gateways/merchant_e_solutions_test.rb",
     "test/unit/gateways/merchant_ware_test.rb",
     "test/unit/gateways/modern_payments_cim_test.rb",
     "test/unit/gateways/moneris_test.rb",
     "test/unit/gateways/net_registry_test.rb",
     "test/unit/gateways/netbilling_test.rb",
     "test/unit/gateways/ogone_test.rb",
     "test/unit/gateways/orbital_paymentech_test.rb",
     "test/unit/gateways/pay_junction_test.rb",
     "test/unit/gateways/pay_secure_test.rb",
     "test/unit/gateways/payflow_express_test.rb",
     "test/unit/gateways/payflow_express_uk_test.rb",
     "test/unit/gateways/payflow_test.rb",
     "test/unit/gateways/payflow_uk_test.rb",
     "test/unit/gateways/payment_express_test.rb",
     "test/unit/gateways/paypal_express_test.rb",
     "test/unit/gateways/paypal_test.rb",
     "test/unit/gateways/plugnpay_test.rb",
     "test/unit/gateways/psigate_test.rb",
     "test/unit/gateways/psl_card_test.rb",
     "test/unit/gateways/quickpay_test.rb",
     "test/unit/gateways/realex_test.rb",
     "test/unit/gateways/sage_bankcard_test.rb",
     "test/unit/gateways/sage_pay_test.rb",
     "test/unit/gateways/sage_virtual_check_test.rb",
     "test/unit/gateways/secure_pay_au_test.rb",
     "test/unit/gateways/secure_pay_tech_test.rb",
     "test/unit/gateways/secure_pay_test.rb",
     "test/unit/gateways/skip_jack_test.rb",
     "test/unit/gateways/trans_first_test.rb",
     "test/unit/gateways/trust_commerce_test.rb",
     "test/unit/gateways/usa_epay_test.rb",
     "test/unit/gateways/verifi_test.rb",
     "test/unit/gateways/viaklix_test.rb",
     "test/unit/gateways/wirecard_test.rb",
     "test/unit/generators/test_gateway_generator.rb",
     "test/unit/generators/test_generator_helper.rb",
     "test/unit/generators/test_integration_generator.rb",
     "test/unit/integrations/action_view_helper_test.rb",
     "test/unit/integrations/bogus_module_test.rb",
     "test/unit/integrations/chronopay_module_test.rb",
     "test/unit/integrations/gestpay_module_test.rb",
     "test/unit/integrations/helpers/bogus_helper_test.rb",
     "test/unit/integrations/helpers/chronopay_helper_test.rb",
     "test/unit/integrations/helpers/gestpay_helper_test.rb",
     "test/unit/integrations/helpers/hi_trust_helper_test.rb",
     "test/unit/integrations/helpers/nochex_helper_test.rb",
     "test/unit/integrations/helpers/paypal_helper_test.rb",
     "test/unit/integrations/helpers/quickpay_helper_test.rb",
     "test/unit/integrations/helpers/two_checkout_helper_test.rb",
     "test/unit/integrations/hi_trust_module_test.rb",
     "test/unit/integrations/nochex_module_test.rb",
     "test/unit/integrations/notifications/chronopay_notification_test.rb",
     "test/unit/integrations/notifications/gestpay_notification_test.rb",
     "test/unit/integrations/notifications/hi_trust_notification_test.rb",
     "test/unit/integrations/notifications/nochex_notification_test.rb",
     "test/unit/integrations/notifications/notification_test.rb",
     "test/unit/integrations/notifications/paypal_notification_test.rb",
     "test/unit/integrations/notifications/quickpay_notification_test.rb",
     "test/unit/integrations/notifications/two_checkout_notification_test.rb",
     "test/unit/integrations/paypal_module_test.rb",
     "test/unit/integrations/quickpay_module_test.rb",
     "test/unit/integrations/returns/chronopay_return_test.rb",
     "test/unit/integrations/returns/gestpay_return_test.rb",
     "test/unit/integrations/returns/hi_trust_return_test.rb",
     "test/unit/integrations/returns/nochex_return_test.rb",
     "test/unit/integrations/returns/paypal_return_test.rb",
     "test/unit/integrations/returns/return_test.rb",
     "test/unit/integrations/returns/two_checkout_return_test.rb",
     "test/unit/integrations/two_checkout_module_test.rb",
     "test/unit/post_data_test.rb",
     "test/unit/posts_data_test.rb",
     "test/unit/response_test.rb",
     "test/unit/utils_test.rb",
     "test/unit/validateable_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
