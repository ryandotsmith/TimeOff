Given /^There are two pending days off$/ do
  2.times { Factory(:dayoff,:state => 0) }
end

