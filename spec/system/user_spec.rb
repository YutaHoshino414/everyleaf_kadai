require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    @user2 = FactoryBot.create(:user_02)
    @user3 = FactoryBot.create(:user_03)
    @user4 = FactoryBot.create(:user_04)
  end
  describe 'ユーザー登録のテスト' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーのマイページが表示される' do
        visit new_user_path
        fill_in 'user_name', with: 'ユーザー01'
        fill_in 'user_email', with: 'user01@test.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'アカウント作成'
        expect(page).to have_content 'ユーザー01'
        expect(page).to have_content 'user01@test.com'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content '下記よりログインする'
        expect(page).to have_content 'ログインが必要です'
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'ログインした場合' do
      it '自分の詳細画面(マイページ)が表示される' do
        visit new_session_path
        fill_in 'session_email', with: 'user02@test.com'
        fill_in 'session_password', with: 'password'
        click_button 'ログインする'
        expect(page).to have_content 'ユーザー02のページ'
        expect(page).to have_content 'ユーザー情報'
        expect(page).to have_content 'Myタスク一覧'
      end
    end
    context '他人の詳細ページに飛んだ場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_session_path
        fill_in 'session_email', with: 'user02@test.com'
        fill_in 'session_password', with: 'password'
        click_button 'ログインする'
        sleep 2
        visit user_path(@user3)
        expect(page).to have_content '権限がありません'
        expect(page).to have_content 'タスク一覧'
        sleep 2
      end
    end
    context 'ログインしたのち、ログアウトした場合' do
      it 'ログアウトでき、ログイン画面に戻る' do
        visit new_session_path
        fill_in 'session_email', with: 'user02@test.com'
        fill_in 'session_password', with: 'password'
        click_button 'ログインする'
        sleep 2
        click_link 'ログアウト'
        sleep 3
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_content 'アカウントをお持ちの方は、下記よりログインする'
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理ユーザーが管理画面へのアクセスした場合' do
      it '管理ユーザーはアクセスできる' do
        visit new_session_path
        fill_in 'session_email', with: 'user04admin@test.com'
        fill_in 'session_password', with: 'password'
        click_button 'ログインする'
        expect(page).to have_content 'ユーザー04のページ'
        sleep 3
        visit admin_users_path
        expect(page).to have_content 'ユーザー管理画面'
      end
      it '一般ユーザーはアクセスできない' do
        visit new_session_path
        fill_in 'session_email', with: 'user02@test.com'
        fill_in 'session_password', with: 'password'
        click_button 'ログインする'
        visit admin_users_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
  end
end