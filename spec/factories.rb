Factory.define :user do |u|
  u.association :account
  u.sequence(:email) {|i| "user#{i}@gmail.com" }
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

Factory.define :account do |a|
  a.company_name     { "wonderset" }
  a.subscription_id  { 1           }
  a.product_handle   { '0-5'       }
end

Factory.define :dayoff do |h|
  h.association :user
  h.leave_length  { 'many'                   }
  h.leave_type    { 'etc'                    }
  h.description   { 'who ha'                 }
  h.state         { 0                        }
  h.reviewed_by   { 'rsmith'                 }
  h.reviewed_on   { DateTime.now             }
  h.begin_time    { MONDAY_THIS_YEAR         }
  h.end_time      { MONDAY_THIS_YEAR + 2.days}
end
