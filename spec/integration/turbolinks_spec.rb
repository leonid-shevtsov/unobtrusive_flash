require 'spec_helper'

if Rails.version =~ /^4\./ and Capybara.javascript_driver == :selenium
  describe "turbolinks spec", type: :feature, js: true do
    it 'should invoke the API for each flash message' do
      visit '/test/turbolinks'
      click_link 'This is a turbolink'
      expect(page).to have_content 'Turbolink content'
      expect(evaluate_script('window.flashMessages')).to eq [
        {'type' => 'notice', 'message' => 'Inline Notice'},
        {'type' => 'notice', 'message' => 'Turbolink Notice'}
      ]
    end
  end
end
