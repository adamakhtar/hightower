require "rails_helper"

feature "admin views segments" do
  scenario "and their users" do
    admin = signed_in_admin

    segment_a = create(:segment, name: 'created first project users')
    segment_a.add_users create(:user, name: 'Mick Jagger')

    segment_b = create(:segment, name: 'slipping away users')
    segment_b.add_users create(:user, name: 'Bob Dylan')

    visit hightower.root_path
    
    click_link t('hightower.nav.segments_link')

    within('.main-panel') do
      expect(page).to have_content 'created first project users'
      expect(page).to have_content 'Mick Jagger'
      expect(page).to_not have_content 'Bob Dylan'
    end

    click_link 'slipping away users'

    within('.main-panel') do
      expect(page).to have_content 'slipping away users'
      expect(page).to have_content 'Bob Dylan'
      expect(page).to_not have_content 'Mick Jagger'
    end
  end

  scenario "and sees no segments notice" do
    admin = signed_in_admin

    visit hightower.segments_path

    expect(page).to have_content t('hightower.segments.none_title')
    expect(page).to have_content t('hightower.segments.no_results')
  end
end
