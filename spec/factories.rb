Factory.sequence :email do |n| 
  "person#{n}@example.com"
end
Factory.define :user do |u|
  u.email Factory.next :email
  u.password "password"
  u.password_confirmation "password"
end

Factory.define :account do |account|
  account.subdomain        { "wonderset" }
  account.users            { |users| [users.association(:user,:email => Factory.next(:email)) ]}
end
