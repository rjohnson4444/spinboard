require 'test_helper'

class AuthenticatedUserCanCreateLinkTest < ActionDispatch::IntegrationTest
  def login_user
    User.create!(email: 'ryan@ryan.me', password: 'password')

    visit login_path
    fill_in "Email", with: 'ryan@ryan.me'
    fill_in "Password", with: 'password'

    click_button "Login"
  end

  # test "authenticated user can create link" do
  #   login_user
  #   prev_link_count = Link.count
  #   save_and_open_page

  #   # fill_in "Title", with: "New Link"
  #   fill_in "Url", with: "http://link.com"

  #   click_button "Create Link"

  #   assert_equal links_path, current_path
  #   assert_equal Link.count, prev_link_count + 1
  # end
end
