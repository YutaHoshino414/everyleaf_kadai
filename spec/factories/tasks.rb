FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'デフォルトのタスク１' }
    content { 'デフォルトのコンテント１' }
    deadline { '02021-01-03' }
    status { 0 }
  end

  factory :second_task, class: Task do
    name { 'デフォルトのタスク２' }
    content { 'デフォルトのコンテント２' }
    deadline { '02021-01-02' }
    status { 1 }
  end

  factory :third_task, class: Task do
    name { 'デフォルトのタスク３' }
    content { 'デフォルトのコンテント３' }
    deadline { '02021-01-01' }
    status { 2 }
  end
end