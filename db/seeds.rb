# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# *** 管理ユーザー1人作成
# name = "admin"
# email = "admin02@example.com"
# password = "password"
# admin = "true"
# User.create!(
#   name: name,
#   email: email,
#   password: password,
#   password_confirmation: password,
#   admin: admin
# )


#最初のユーザをseedで作成する(済み)
# name = "user01"
# email = "user01@test.com"
# password = "password"
# User.create!(
#   name: name,
#   email: email,
#   password: password,
#   password_confirmation: password,
# )
#2つ目のuser(ブラウザ操作にて作成)
#name =test01
#email = "test@test.com"
#password = "password"

# admin01
# admin@test.com
# password 

# *** ラベル作成
@count = 1
3.times do |n|
  name = " ラベル#{@count} "
  Label.create!(name: name)
  @count += 1
end