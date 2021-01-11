class Task < ApplicationRecord
  validates :name, :content, presence: true

  enum status:{ 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority:{ 底: 0, 中: 1, 高: 2 }
end
