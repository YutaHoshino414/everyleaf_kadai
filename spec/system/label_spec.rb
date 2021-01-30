require 'rails_helper'
RSpec.describe 'ラベル追加機能検証', type: :system do
  before do
    user = FactoryBot.create(:user_04)
    @label = FactoryBot.create(:label)
    @label2 = FactoryBot.create(:label_second)
    @label3 = FactoryBot.create(:label_third)
    @task = FactoryBot.create(:task, user: user)
    @task2 = FactoryBot.create(:second_task, user: user)
    @task3 = FactoryBot.create(:third_task, user: user)
    FactoryBot.create(:labelling, task: @task, label: @label)
    FactoryBot.create(:labelling, task: @task2, label: @label2)
    FactoryBot.create(:labelling, task: @task3, label: @label3)
  end
  describe '新規作成機能' do
    let!(:login) {
        visit new_session_path
        fill_in 'session_email', with: 'user04admin@test.com'
        fill_in 'session_password', with: 'password'
        click_button 'ログインする'
      }
    context 'タスクを新規作成する際' do
      it 'ラベルも一緒に登録できる' do

        visit new_task_path
        fill_in 'task_name', with: 'タスク01'
        fill_in 'task_content', with: 'タスク詳細01'
        fill_in 'task_deadline', with: '02021-01-12'
        select '着手中', from: 'task[status]'
        check 'ラベル3'
        sleep 2
        click_on '登録'
        expect(page).to have_content 'タスク01'
        expect(page).to have_content 'ラベル3'
        # save_and_open_page
      end
    end
  end
  describe '編集機能' do
    let!(:login) {
        visit new_session_path
        fill_in 'session_email', with: 'user04admin@test.com'
        fill_in 'session_password', with: 'password'
        click_button 'ログインする'
      }
    context 'タスクを編集する際' do
      it 'ラベルも一緒に編集できる' do
        visit tasks_path
        visit edit_task_path(@task)
        uncheck 'ラベル1'
        check 'ラベル2'
        sleep 1
        click_button '更新する'
        visit task_path(@task)
        sleep 2
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content 'デフォルトのタスク１'
        expect(page).to have_content 'ラベル2'
      end
    end
  end 
  describe '検索機能' do
    let!(:login) {
      visit new_session_path
      fill_in 'session_email', with: 'user04admin@test.com'
      fill_in 'session_password', with: 'password'
      click_button 'ログインする'
    }
    context 'ラベルで検索した場合' do
      it '該当のラベルを含むタスクが表示される' do
        visit tasks_path
        select 'ラベル3', from: 'label_id'
        sleep 1
        click_on '検索'
        task = all('tbody tr')
        sleep 3
        expect(task.first).to have_content 'デフォルトのタスク３'
        expect(task.first).to have_content 'ラベル3'
      end
    end
  end
end
