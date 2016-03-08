require 'test_helper'

class UserCanLoginAndLogoutTest < ActionDispatch::IntegrationTest
  def create_user
    User.create!(
      email: 'leon@email.com',
      password: 'password'
    )
  end

  test "registered user can login" do
    user = create_user

    visit login_path

    fill_in "Email", with: 'leon@email.com'
    fill_in "Password", with: 'password'

    click_button "Login"

    assert_equal links_path, current_path
    assert page.has_content?("Logout")
  end

  test "unregistered user cannot login" do
    visit login_path

    fill_in "Email", with: 'leon@email.com'
    fill_in "Password", with: 'password'

    click_button "Login"

    assert_equal login_path, current_path
    refute page.has_content?("Logout")
  end

  test "registered user can logout" do
    user = create_user

    visit login_path

    fill_in "Email", with: 'leon@email.com'
    fill_in "Password", with: 'password'

    click_button "Login"

    assert_equal links_path, current_path
    assert page.has_content?("Logout")

    click_link "Logout"

    assert_equal home_path, current_path
  end
end
