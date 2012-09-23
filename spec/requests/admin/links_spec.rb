# coding: utf-8
require 'spec_helper'

feature "Editing a link" do
  background do
    load "#{Rails.root}/spec/requests/section_seed.rb"

    u = User.new password: 'passuu', first_name: "Example", last_name: "User"
    u.email = "user@example.com"
    u.confirm!

    category = LinkCategory.create! section: Section.first, name: "A Category"
    category.links.create! name: "Existing Link", url: "http://example.com"
  end

  scenario "Editing an existing link" do
    log_in_to_admin
        
    click_link "Linkit"
    click_link "A Category"
    within("td.action") { find("a").click }
    puts page.current_url
    fill_in "Nimi", with: "Modified Link"
    click_button "Tallenna"

    page.should have_content("Modified Link")
  end

  def log_in_to_admin
    visit("/admin")
    fill_in 'Sähköposti', with: 'user@example.com'
    fill_in 'Salasana', with: 'passuu'
    click_button "Kirjaudu"
  end
end
