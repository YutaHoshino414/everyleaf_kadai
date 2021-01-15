class Task < ApplicationRecord
  validates :name, :content, presence: true
  validates :deadline, :status, :priority, presence:true
  
  scope :name_like, -> (name) {where('(name LIKE ?)',"%#{name}%")}
  scope :status_is, -> (status) { where(status: status) }

  enum status:{ 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority:{ 低: 0, 中: 1, 高: 2 }

  belongs_to :user
end
