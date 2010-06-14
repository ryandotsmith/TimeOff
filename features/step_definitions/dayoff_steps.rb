Given /^There are two pending days off$/ do
  2.times { Factory(:dayoff,:account => @account) }
end

Given /^There are two pending days off for another account$/ do
  account = Factory(:account,:company_name=> 'another')
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

Given /^I have approved time off$/ do
  @dayoff= Factory(:dayoff,:state => 1,:leave_type => 'vacation',:leave_length => 'whole',:user => @user, :begin_time => DateTime.now + 4.days, :end_time => DateTime.now + 5.days)
  @account.daysoff << @dayoff
  @account.save
end

Given /^Someone else has approved time off$/ do
  another_user = Factory(:user)
  @dayoff= Factory(:dayoff,:state => 1,:leave_type => 'vacation',:leave_length => 'whole',:user => another_user, :begin_time => DateTime.now + 4.days, :end_time => DateTime.now + 5.days)
  @account.daysoff << @dayoff
  @account.save
end

Given /^Someone else has pending time off$/ do
  @another_user = Factory(:user)
  @dayoff= Factory(:dayoff,:state => 0,:leave_type => 'vacation',:leave_length => 'whole',:user => @another_user, :begin_time => DateTime.now + 4.days, :end_time => DateTime.now + 5.days)
  @account.daysoff << @dayoff
  @account.save
end

Then /^I should have created a dayoff$/ do
  Dayoff.count.should eql(1)
  @dayoff = Dayoff.first
end

Then /^I should see the dayoff in the table$/ do
  Then %{I should see "#{@dayoff.status}" within "#dayoff_#{@dayoff.id}"}
end

Then /^I should have my dayoff on the calendar$/ do
  Then %{I should see "#{@dayoff.user.name}" within ".fc-event-title"}
end

Then /^I should not see someone elses dayoff in the calendar$/ do
  Then %{I should not see "#{@dayoff.user.name}" within ".fc-day-content"}
end

Then /^I should see the request in the Pending Requests Queue$/ do
  Then %{I should see "#{@dayoff.user.name}" within "td.name"}
end

