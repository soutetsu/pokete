module FeatureHelper
  def sign_in_as(user, password = 'xxx')
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: password
    find('[name=commit]').click
  end
end
