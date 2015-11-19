require 'spec_helper'

describe "bootstrap spec", type: :feature, js: true do
  it 'should show each flash message' do
    visit '/test/bootstrap'
    expect(page).to have_content 'Page loaded'
    expect(page).to have_content 'Inline Notice', count: 1
    expect(page).to have_content 'Ajax Error', count: 1
  end

  it 'should translate rails message types into bootstrap alert classes' do
    visit '/test/bootstrap'
    expect(page).to have_content 'Page loaded'
    within('.alert.alert-info') { expect(page).to have_content 'Inline Notice' }
  end

  it 'should bind close buttons for the messages' do
    visit '/test/bootstrap'
    expect(page).to have_content 'Inline Notice'
    find('.alert.alert-info .close').click
    expect(page).to have_no_content 'Inline Notice'
  end

  it 'should append new messages to existing messages when the JS option clearFlashOnNextRequest is set to false (which is the default)' do
    visit '/test/bootstrap'
    expect(page).to have_content 'Ajax Error', count: 1
    page.execute_script("$.get('/test/ajax_flash');")
    expect(page).to have_content 'Ajax Error', count: 2
  end

  it 'should clear existing messages before displaying new messages when the JS option clearFlashOnNextRequest is set to true' do
    visit '/test/bootstrap'
    page.execute_script('UnobtrusiveFlash.flashOptions.clearFlashOnNextRequest = true;')
    expect(page).to have_content 'Ajax Error', count: 1
    page.execute_script("$.get('/test/ajax_flash');")
    expect(page).to have_content 'Ajax Error', count: 1
  end
end
