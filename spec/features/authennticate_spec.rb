require 'rails_helper'

RSpec.feature '認証', type: :feature do
  given!(:user) { create(:user) }
  given!(:another_user) { create(:user) }

  background do
    sign_in_as user
    create_theme
    click_link 'サインアウト'
    sign_in_as another_user
    create_boke(user.themes.last)
    click_link 'サインアウト'
  end

  context 'サインインしている場合' do
    background do
      sign_in_as user
    end

    feature 'お題 一覧' do
      background do
        visit themes_path
      end
      scenario 'お題作成ボタンが表示されている' do
        expect(page).to have_link nil, href: new_my_theme_path
      end
    end

    feature 'ボケ 一覧' do
      given(:boke) { Boke.last }
      background do
        visit recent_bokes_path
      end
      scenario 'ボケを評価ボタンが表示されている' do
        visit theme_boke_path(boke, theme_id: boke.theme.id)
        expect(page).to have_link nil, href: new_my_theme_boke_evaluation_path(theme_id: boke.theme.id, boke_id: boke.id)
      end
    end
  end

  context 'サインインしていない場合' do
    feature 'お題 一覧' do
      scenario 'お題作成ボタンが表示されていない' do
        expect(page).not_to have_link nil, href: new_my_theme_path
      end

      scenario 'お題作成用 URL にアクセスできない' do
        visit new_my_theme_path
        expect(current_path).to eq(new_user_session_path)
      end
    end

    feature 'ボケ 一覧' do
      given(:boke) { Boke.last }
      background do
        visit recent_bokes_path
      end
      scenario 'ボケを評価ボタンが表示されていない' do
        visit theme_boke_path(boke, theme_id: boke.theme.id)
        expect(page).not_to have_link nil, href: new_my_theme_boke_evaluation_path(theme_id: boke.theme.id, boke_id: boke.id)
      end
    end
  end
end
