require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

namespace 'timeoff' do
  desc "reset all passwords to 'password'"
  task :reset_passwords do
    User.all.each do |user|
      user.password = 'password'
      user.password_confirmation = 'password'
      user.save!
    end
  end

end
