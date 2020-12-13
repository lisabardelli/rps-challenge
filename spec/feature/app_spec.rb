require "capybara/rspec"
require_relative "../../lib/app"
require_relative "web_helper"
require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

Capybara.app = Rps

feature Rps do
  scenario 'returns something on the root url' do
    visit('/')
    expect(page).to have_content "MAMA"
  end

  scenario "entering players' name" do
    sign_in_and_play
    expect(page).to have_content "Lisa"
    expect(page).to have_content "Paul"
  end
  scenario "playing game" do
    sign_in_and_play
    visit('/game')
    expect(page).to have_button("Play!")
  end

  scenario "showing players' score" do
    sign_in_and_play
    visit("/score")
    expect(page).to have_content("Ties")
  end
  scenario "resetting game" do
    sign_in_and_play
    visit("/reset")
    expect(page).to have_content("move")
  end

end