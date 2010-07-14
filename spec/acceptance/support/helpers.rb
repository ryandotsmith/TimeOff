module HelperMethods
  def sign_in_as(user)
    visit '/signin'
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => 'password'
    click_button "sign in"
  end
end

Spec::Runner.configuration.include(HelperMethods)
