module FeatureHelper
  def sign_in_as(user, password = 'xxx')
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: password
    find('[name=commit]').click
  end

  def create_theme
    visit new_my_theme_path
    attach_file 'theme[uri]', "#{Rails.root}/spec/support/dummy.jpg"
    choose 'その他'
    find('[name=commit]').click
  end

  def create_boke(theme)
    visit new_my_theme_boke_path(theme)
    fill_in 'boke[content]', with: Faker::Lorem.paragraph
    find('[name=commit]').click
  end

  def create_evaluation(boke)
    visit new_my_theme_boke_evaluation_path(theme_id: boke.theme.id, boke_id: boke.id)
    fill_in 'evaluation[point]', with: [*1..5].sample
    fill_in 'evaluation[comment]', with: Faker::Lorem.paragraph
    find('[name=commit]').click
  end
end
