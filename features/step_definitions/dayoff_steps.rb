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

Given /^I have 1 unapproved vacation dayoff$/ do
  @dayoff = Factory(:dayoff,:user => @user, :begin_time => DateTime.now, :end_time => DateTime.now + 2.days)
  @account.daysoff << @dayoff
  @account.save
end

Given /^I have 2 approved vacation daysoff$/ do
  @dayoff1= Factory(:dayoff,:state => 1,:leave_type => 'vacation',:leave_length => 'whole',:user => @user, :begin_time => DateTime.now + 4.days, :end_time => DateTime.now + 5.days)
  @dayoff2= Factory(:dayoff,:state => 1,:leave_type => 'vacation',:leave_length => 'whole',:user => @user, :begin_time => DateTime.now + 6.days, :end_time => DateTime.now + 7.days)
  @account.daysoff << @dayoff1
  @account.daysoff << @dayoff2
  @account.save
end

