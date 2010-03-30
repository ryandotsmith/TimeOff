Given /^an account exists with a subdomain of "([^\"]*)"$/ do |subdomain|
  account = Factory(:account,:subdomain => subdomain)
  #host! "#{account.subdomain}.example.com"
end


