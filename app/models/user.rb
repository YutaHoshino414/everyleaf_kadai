class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :tasks, dependent: :destroy
  
  before_update :admin_change_check
  before_destroy :admin_change_check
  def admin_change_check
    target = User.find_by(id: self.id)
    if User.where(admin: true).count <= 2
      if target.admin
        throw :abort
      end
    end
  end

end
