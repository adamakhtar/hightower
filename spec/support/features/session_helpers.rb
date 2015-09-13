module SessionHelpers
  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button 'Log in'
  end

  def sign_in(user)
    sign_in_with user.email, user.password
  end

  def signed_in_admin
    user = create(:admin)
    sign_in_with user.email, user.password
    user
  end
end

RSpec.configure do |config|
  config.include SessionHelpers, type: :feature
end