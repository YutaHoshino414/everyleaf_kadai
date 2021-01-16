FactoryBot.define do
  factory :user_02, class: User do
    name { 'ユーザー02' }
    email { 'user02@test.com' }
    password { 'password' }
    admin { 'false' }
  end
  factory :user_03, class: User do
    name { 'ユーザー03' }
    email { 'user03@test.com' }
    password { 'password' }
    admin { 'false' }
  end
  factory :user_04, class: User do
    name { 'ユーザー04' }
    email { 'user04admin@test.com' }
    password { 'password' }
    admin { 'true' }
  end

end
