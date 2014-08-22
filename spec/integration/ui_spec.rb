require 'spec_helper'

describe "ui spec", type: :feature, js: true do
  it 'should show each flash message' do
    visit '/test/ui'
    expect(page).to have_content 'Page loaded'
    expect(page).to have_content 'Inline Notice', count: 1
    expect(page).to have_content 'Ajax Error', count: 1
  end
end
