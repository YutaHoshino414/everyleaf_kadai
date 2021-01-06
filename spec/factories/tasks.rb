FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'デフォルトのタスク１' }
    content { 'デフォルトのコンテント１' }
  end

  factory :second_task, class: Task do
    name { 'デフォルトのタスク２' }
    content { 'デフォルトのコンテント２' }
  end
end