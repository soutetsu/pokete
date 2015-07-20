require 'rails_helper'

RSpec.feature 'ボケへの評価' do
  given!(:theme_user) { create(:user) }
  given!(:boke_user) { create(:user) }

  background do
    sign_in_as theme_user
    create_theme
    click_link nil, href: destroy_user_session_path
    sign_in_as boke_user
    create_boke(theme_user.themes.last)
    click_link nil, href: destroy_user_session_path
    sign_in_as theme_user
    visit polymorphic_path([:recent, :bokes])
  end

  scenario '新規作成' do
    boke = boke_user.bokes.last
    expect { create_evaluation(boke) }.to change{ Evaluation.count }.by(1)
    expect(current_path).to eq polymorphic_path([boke.theme, boke])
    expect(page).to have_css('.alert-success')
  end

  scenario '削除' do
    boke = boke_user.bokes.last
    create_evaluation(boke)
    expect {
      click_link nil, href: polymorphic_path([:my, boke.theme, boke, boke.evaluations.last])
    }.to change{ Evaluation.count }.by(-1)
  end
end
