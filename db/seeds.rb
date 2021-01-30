# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# herokuへ10件づつ
@count = 1
10.times do |n|
  name = " ラベル#{@count} "
  Label.create!(name: name)
  @count += 1
end

10.times do |n|
  name = "test#{@count}"
  email = "#{name}@hoge.com"
  password = "password"
  admin = true
  @user = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    admin: admin
  )

    10.times do |n|
      name = "タスク#{@count}"
      content = "タスク内容#{@count}"
      deadline = "02021-01-30"
      status = 0
      priority = 0
      user_id = @user.id
      Task.create!(
        name: name,
        content: content,
        deadline: deadline,
        status: status,
        priority: priority,
        user_id: user_id
      )
    end
  @count += 1
end


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
# @count = 1
# 3.times do |n|
#   name = " ラベル#{@count} "
#   Label.create!(name: name)
#   @count += 1
# end