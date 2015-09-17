require "rails_helper"

feature "admin views users" do
  scenario "as a list" do
    admin = signed_in_admin

    user_a = create(:user, name: 'Sonic Hedgehog')
    user_b = create(:user, name: 'Chun Li')

    visit hightower.root_path
    
    click_link t('hightower.nav.users_link')

    within('.main-panel') do
      expect(page).to have_content 'Sonic Hedgehog'
      expect(page).to have_content 'Chun Li'
    end
  end

  scenario "in detail" do
    admin = signed_in_admin

    user = create(:user, name: 'Mick Jagger')
    event   = create(:event, user: user, action: 'logged in')
    segment = create(:segment, name: 'slipping away users')
    segment.add_users user

    visit hightower.users_path

    click_link 'Mick Jagger'

    expect(page).to have_content 'Mick Jagger'
    expect(page).to have_content 'slipping away users'
    expect(page).to have_content 'logged in'
  end
end
