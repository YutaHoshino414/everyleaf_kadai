require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    @task = FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: 'タスク01'
        fill_in 'task_content', with: 'タスク詳細01'
        fill_in 'task_deadline', with: '02021-01-12'
        select '着手中', from: 'task[status]'
        click_on '登録'
        expect(page).to have_content 'タスク01'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task01')
        visit tasks_path
        expect(page).to have_content 'task01'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # ここに実装する
        visit tasks_path
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトのタスク３'
        expect(task[1]).to have_content 'デフォルトのタスク２'
        expect(task[2]).to have_content 'デフォルトのタスク１'
      end
    end
    context '終了期限をクリックした場合' do
      it '終了期限の降順で表示される' do
        visit tasks_path
        visit current_path
        click_link '終了期限でソートする' 
        sleep 3
        task = all('tbody tr')
        expect(task[0]).to have_content 'デフォルトのタスク１'
        expect(task[1]).to have_content 'デフォルトのタスク２'
        expect(task[2]).to have_content 'デフォルトのタスク３'
      end
    end

    context 'タスク名のみで検索した場合' do
      it 'タスク名の検索結果が反映されたタスクが表示される' do
        visit tasks_path
        fill_in 'name', with: 'タスク１'
        click_on '検索' 
        expect(page).to have_content 'タスク１'
      end
    end
    context 'ステータスのみで検索した場合' do
      it 'ステータスの検索結果が反映されたタスクが表示される' do
        visit tasks_path
        # select '着手中', from: 'task_status'
        find("option[value='着手中']").select_option
        click_on '検索'
        task = all('tbody tr')
        expect(task.first).to have_content 'タスク２'
      end
    end
    context 'タスク名とステータスで検索した場合' do
      it '両方の検索結果が反映されたタスクが表示される' do
        visit tasks_path
        fill_in 'name', with: 'デフォルト'
        find("option[value='完了']").select_option
        sleep 2.5
        click_on '検索'
        task = all('tbody tr')
        expect(task.first).to have_content 'タスク３'

      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit task_path(@task)
        expect(page).to have_content 'デフォルトのタスク２'
       end
     end
  end
end