require 'test_helper'

class UserCanSignUpTest < ActionDispatch::IntegrationTest
  test "unauthenticated user can see login and sign up links at root" do
    visit root_path

    assert page.has_link?("Login")
    assert page.has_link?("Sign Up")
  end

  test "unauthenticated user is taken to user form when sign up is clicked" do
    prev_user_count = User.count
    visit root_path

    assert_equal User.count, prev_user_count

    click_link("Sign Up")

    fill_in "Email", with: "rjohn111@email.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"

    click_button "Create Account"

    assert_equal '/links', current_path
    assert_equal User.count, prev_user_count + 1
    assert page.has_content?("Logout")
  end

  test "unauthenticated user cannot signup when password confirmation does not match password" do
    prev_user_count = User.count
    visit root_path

    click_link("Sign Up")

    fill_in "Email", with: "rjohn111@email.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password"

    click_button "Create Account"

    assert_equal new_user_path, current_path
    assert_equal User.count, prev_user_count
    refute page.has_content?("Logout")
  end
end
