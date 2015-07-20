require 'rails_helper'

RSpec.feature 'お題' do
  given!(:user) { create(:user) }

  background do
    sign_in_as user
  end

  scenario '新規登録' do
    expect {
      create_theme
    }.to change{ Theme.count }.by(1)
  end

  scenario '変更' do
    create_theme
    visit themes_path
    expect {
      click_link nil, href: polymorphic_path([:edit, :my, user.themes.last])
      choose Category.last.name
      find('[name=commit]').click
    }.not_to change{ Theme.count }
    expect(current_path).to eq my_themes_path
    expect(page).to have_css('.alert-success')
  end

  scenario '削除' do
    create_theme
    visit themes_path
    expect {
      click_link nil, href: polymorphic_path([:my, user.themes.last])
    }.to change{ Theme.count }.by(-1)
  end
end
