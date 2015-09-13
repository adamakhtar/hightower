require "rails_helper"

feature "admin views users" do
  scenario "as a list" do
    admin = signed_in_admin

    user_a = create(:user, name: 'Sonic Hedgehog')
    user_b = create(:user, name: 'Chun Li')

    visit hightower.root_path
    
    click_link t('hightower.nav.users_link')

    within('.main') do
      expect(page).to have_content 'Sonic Hedgehog'
      expect(page).to have_content 'Chun Li'
    end
  end
end
