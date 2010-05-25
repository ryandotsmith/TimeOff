Given /^There are two pending days off$/ do
  2.times { Factory(:dayoff,:account => @account) }
end
Given /^There are two pending days off for another account$/ do
  account = Factory(:account,:subdomain => 'another')
  2.times { Factory(:dayoff, :account => account) }
end

Given /^The user is asking for 2 days off$/ do
  @dayoff = Factory(:dayoff,:user => @user, :begin_time => DateTime.now, :end_time => DateTime.now + 2.days)
  @account.daysoff << @dayoff
  @account.save
end

