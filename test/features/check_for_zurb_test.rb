require "test_helper"

feature "CheckForZurb" do
  scenario "When visiting the page Zurb Foundation will be installed" do
    visit root_path
    page.source.must_include("foundation_and_overrides.css") 
    page.wont_have_content "Goobye All!"
  end
end