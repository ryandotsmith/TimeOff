require 'yaml'

YAML::add_private_type("OldUser") do |type, value|
  OldUser.new(value)
end

YAML::add_private_type("Dayoff") do |type, value|
  Dayoff.new(value)
end


module GSE
  class Import
    def self.load_users
      @root = User.new(:first_name => 'system', :last_name => 'root', :email => 'this.ryansmith@gmail.com')
      @root.generate_one_time_password!
      @root.activate!
      @root.save!

      @account = ::Account.new(:company_name => "GS Enterprises Inc.")
      @account.users << @root
      @account.save

      users = YAML::load_file(File.expand_path(File.dirname(__FILE__) + '/old_users.yml'))
      users.each do |user|
        new_user = @account.users.build
        attrs    = user.ivars['attributes']
        new_user.id                     = attrs['id']
        new_user.first_name             = attrs['name'].split.first
        new_user.last_name              = attrs['name'].split.last
        new_user.email                  = attrs['email']
        new_user.date_of_hire           = Date.parse(attrs['date_of_hire']).to_datetime if attrs['date_of_hire']
        new_user.password               = 'Gs*123*truck'
        new_user.password_confirmation  = 'Gs*123*truck'
        new_user.activate!

        @account.users << new_user
        new_user.save
      end
    end
    def self.load_daysoff
      daysoff = YAML::load_file(File.expand_path(File.dirname(__FILE__) + '/daysoff.yml'))
      daysoff.each do |dayoff|
        attrs = dayoff.ivars['attributes']
        user = User.find_by_id(attrs['user_id'])
        next if user.nil?
        new_dayoff            = user.daysoff.build
        new_dayoff.id         = attrs['id'].to_i
        new_dayoff.account_id = user.account.id
        new_dayoff.created_at = DateTime.parse(attrs['created_at']).to_datetime
        new_dayoff.reviewed_by= attrs['reviewed_by']
        new_dayoff.reviewed_on= DateTime.parse(attrs['reviewed_on']).to_datetime if attrs['reviewed_on']
        new_dayoff.begin_time = DateTime.parse(attrs['begin_time']).to_datetime if attrs['begin_time']
        new_dayoff.end_time   = DateTime.parse(attrs['end_time']).to_datetime if attrs['end_time']
        new_dayoff.description=attrs['description']
        new_dayoff.leave_type =attrs['leave_type']
        new_dayoff.state      = attrs['state'].to_i
        puts "saved" if new_dayoff.save!
      end
    end
  end
end
