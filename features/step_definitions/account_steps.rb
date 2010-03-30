Given /^An account$/ do
  account = Factory(:account)
  host! "#{account.subdomain}.example.com"
end

