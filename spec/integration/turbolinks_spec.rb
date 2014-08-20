require 'spec_helper'

if Rails.version =~ /^4\./
  describe "turbolinks spec", type: :feature, js: true, sauce: true do
    it 'should invoke the API for each flash message' do
      visit '/test/turbolinks'
      save_and_open_page
      click_link 'This is a turbolink'
      expect(page).to have_content 'Turbolink content'
      save_and_open_page
      expect(evaluate_script('window.flashMessages')).to eq [
        {'type' => 'notice', 'message' => 'Inline Notice'},
        {'type' => 'notice', 'message' => 'Turbolink Notice'}
      ]
    end
  end
end
