require 'rails_helper'

RSpec.feature 'ボケ' do
  given!(:theme_user) { create(:user) }
  given!(:boke_user) { create(:user) }

  background do
    sign_in_as theme_user
    create_theme
    click_link nil, href: destroy_user_session_path
    sign_in_as boke_user
  end

  scenario '新規作成' do
    visit themes_path
    click_link nil, href: polymorphic_path([:new, :my, theme_user.themes.last, :boke])
    expect {
      create_boke(theme_user.themes.last)
    }.to change { Boke.count }.by(1)
    expect(current_path).to eq polymorphic_path([:recent, :bokes])
    expect(page).to have_css('.alert-success')
  end

  scenario '変更' do
    create_boke(theme_user.themes.last)
    visit polymorphic_path([:recent, :bokes])
    expect {
      boke = boke_user.bokes.last
      click_link nil, href: polymorphic_path([:edit, :my, boke.theme, boke])
      fill_in 'boke[content]', with: Faker::Lorem.word
      find('[name=commit]').click
    }.not_to change { Boke.count }
  end

  scenario '削除' do
    create_boke(theme_user.themes.last)
    visit polymorphic_path([:recent, :bokes])
    boke = boke_user.bokes.last
    expect {
      click_link nil, href: polymorphic_path([:my, boke.theme, boke])
    }.to change { Boke.count }.by(-1)
  end
end
