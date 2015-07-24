Braintree::Configuration.environment  = ENV['BRAINTREE_ENV']         || :sandbox
Braintree::Configuration.merchant_id   = ENV['BRAINTREE_MERCHANT_ID'] || 'your merchant id'
Braintree::Configuration.public_key   = ENV['BRAINTREE_PUBLIC_KEY']  || 'your public api'
Braintree::Configuration.private_key  = ENV['BRAINTREE_PRIVATE_KEY'] || 'your private key'

