require 'spec_helper'

describe "ui spec", type: :feature, js: true do
  it 'should show each flash message' do
    visit '/test/ui'
    expect(page).to have_content 'Page loaded'
    expect(page).to have_content 'Inline Notice', count: 1
    expect(page).to have_content 'Ajax Error', count: 1
  end

  it 'should append new messages to existing messages when the JS option clearFlashOnNextRequest is set to false (which is the default)' do
    visit '/test/ui'
    expect(page).to have_content 'Ajax Error', count: 1
    page.execute_script("$.get('/test/ajax_flash');")
    expect(page).to have_content 'Ajax Error', count: 2
  end

  it 'should clear existing messages before displaying new messages when the JS option clearFlashOnNextRequest is set to true' do
    visit '/test/ui'
    page.execute_script('UnobtrusiveFlash.flashOptions.clearFlashOnNextRequest = true;')
    expect(page).to have_content 'Ajax Error', count: 1
    page.execute_script("$.get('/test/ajax_flash');")
    expect(page).to have_content 'Ajax Error', count: 1
  end
end
