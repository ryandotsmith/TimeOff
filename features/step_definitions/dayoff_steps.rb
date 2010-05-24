Given /^There are two pending days off$/ do
  2.times { Factory(:dayoff,:account => @account) }
end
Given /^There are two pending days off for another account$/ do
  account = Factory(:account,:subdomain => 'another')
  2.times { Factory(:dayoff, :account => account) }
end


