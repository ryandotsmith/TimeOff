Factory.sequence :email do |n|
  "person#{n}@example.com"
end

Factory.sequence(:subscription_id) {|n| n}

Factory.define :user do |u|
  u.email                 { Factory.next(:email) }
  u.first_name            {"Ryan"                }
  u.last_name             {"Smith"               }
  u.password              {"password"            }
  u.password_confirmation {"password"            }
  u.max_vacation          { 10.0                 }
  u.max_personal          { 10.0                 }
  u.max_etc               { 10.0                 }
  u.active                { true                 }
end

Factory.define :manager, :parent => :user  do |manager|
  manager.manager { true }
end

Factory.define :account do |account|
  account.company_name     { "wonderset" }
  account.subscription_id  { 1           }
  account.product_handle   { '0-5'       }
  account.users            { |users| [users.association(:user,:email => Factory.next(:email)) ]}
end

Factory.define :dayoff do |h|
  h.leave_length  { 'many'                   }
  h.leave_type    { 'etc'                    }
  h.description   { 'who ha'                 }
  h.state         { 0                        }
  h.reviewed_by   { 'rsmith'                 }
  h.reviewed_on   { DateTime.now             }
  h.begin_time    { MONDAY_THIS_YEAR         }
  h.end_time      { MONDAY_THIS_YEAR + 2.days}
  h.association :user
end
