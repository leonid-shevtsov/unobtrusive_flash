require 'spec_helper'

describe "api spec", type: :feature, js: true do
  it 'should invoke the API for each flash message' do
    visit '/test/api'
    expect(page).to have_content 'Page loaded'
    expect(evaluate_script('window.flashMessages')).to eq [
      {'type' => 'notice', 'message' => 'Inline Notice'},
      {'type' => 'error', 'message' => 'Ajax Error'}
    ]
  end
end
