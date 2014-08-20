require 'spec_helper'

describe "bootstrap spec", type: :feature, js: true, sauce: true do
  it 'should show each flash message' do
    visit '/test/bootstrap'
    expect(page).to have_content 'Page loaded'
    expect(page).to have_content 'Inline Notice'
    expect(page).to have_content 'Ajax Error'
  end

  it 'should translate rails message types into bootstrap alert classes' do
    visit '/test/bootstrap'
    expect(page).to have_content 'Page loaded'
    save_and_open_page
    within('.alert.alert-info') { expect(page).to have_content 'Inline Notice' }
  end

  it 'should bind close buttons for the messages' do
    visit '/test/bootstrap'
    expect(page).to have_content 'Inline Notice'
    find('.alert.alert-info .close').click
    sleep 1 # for the flash message to fade out
    expect(page).to_not have_content 'Inline Notice'
  end
end
