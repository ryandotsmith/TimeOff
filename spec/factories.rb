Factory.sequence :email do |n| 
  "person#{n}@example.com"
end

Factory.define :user do |u|
  u.email                 { Factory.next(:email) }
  u.first_name            {"Ryan"                }
  u.last_name             {"Smith"               }
  u.password              {"password"            }
  u.password_confirmation {"password"            }
end

Factory.define :account do |account|
  account.subdomain        { "wonderset" }
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
