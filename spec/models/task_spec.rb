require 'rails_helper'

RSpec.describe Task, type: :model do
 
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(name: '', content: '失敗テスト')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          task = Task.new(name: '失敗テスト', content: '')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          task = Task.new(name: '成功テスト', content: '成功テスト', deadline:'2021-01-13')
          expect(task).to be_valid
        end
      end
    end
    describe 'タスクモデル機能', type: :model do
      describe '検索機能' do
        # # 必要に応じて、テストデータの内容を変更して構わない
        # let!(:task) { FactoryBot.create(:task, name: 'task') }
        # let!(:second_task) { FactoryBot.create(:second_task, name: "sample") }
        before do
          
          @task1 = FactoryBot.create(:task)
          @task2 = FactoryBot.create(:second_task)
          @task3 = FactoryBot.create(:third_task)
        end
        context 'scopeメソッドでタイトルのあいまい検索をした場合' do
          it "検索キーワードを含むタスクが絞り込まれる" do
            # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
            expect(Task.name_like('タスク１')).to include(@task1)
            expect(Task.name_like('タスク１')).not_to include(@task2)
            expect(Task.name_like('タスク１')).not_to include(@task3)
            expect(Task.name_like('タスク１').count).to eq 1
          end
        end
        context 'scopeメソッドでステータス検索をした場合' do
          it "ステータスに完全一致するタスクが絞り込まれる" do
            # ここに内容を記載する
            expect(Task.status_is('着手中')).to include(@task2)
            expect(Task.status_is('着手中')).not_to include(@task1)
            expect(Task.status_is('着手中')).not_to include(@task3)
            expect(Task.status_is('着手中').count).to eq 1
          end
        end
        context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
          it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
            # ここに内容を記載する
            expect(Task.name_like('タスク３').status_is('完了')).to include(@task3)
            expect(Task.name_like('タスク３').status_is('完了')).not_to include(@task1)
            expect(Task.name_like('タスク３').status_is('完了')).not_to include(@task2)
            expect(Task.name_like('タスク３').status_is('完了').count).to eq 1
          end
        end
      end
    end
end


