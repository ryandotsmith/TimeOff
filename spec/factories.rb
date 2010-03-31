Factory.sequence :email do |n| 
  "person#{n}@example.com"
end

Factory.sequence :token do |n| 
  "k3cFzLIQnZ#{n}MHRmJvJzg"
end

Factory.define :user do |u|
  u.email Factory.next :email
  u.password "password"
  u.password_confirmation "password"
  u.single_access_token Factory.next :token
end

Factory.define :account do |account|
  account.subdomain        { "wonderset" }
  account.users            { |users| [users.association(:user,:email => Factory.next(:email), :single_access_token => Factory.next(:token))]}
end
