# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email:'test@test.com',
   password: '******',
)

users = User.create!(
   [
    {email: 'olivia@test.com', name: 'Olivia', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.PNG"), filename:"sample-user1.PNG")},
    {email: 'james@test.com', name: 'James', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.PNG"), filename:"sample-user2.PNG")},
    {email: 'lucas@test.com', name: 'Lucas', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.PNG"), filename:"sample-user3.PNG")}
   ]
)

Post.create!(
  [
    {title: 'ダブルボトム', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.png"), filename:"sample-post1.png"), body: 'ダブルボトムは下降トレンド終了時に出現し、上昇トレンドに切り替わる可能性が高い。エントリーポイントはネックライン。', user_id: users[0].id },
    {title: 'USDJPY', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.png"), filename:"sample-post2.png"), body: 'USDJPYは今年の3月から急激に上がり始めて、８月に130円台まで下がったがまた上がり始めた。140円まで届きそう。', user_id: users[1].id },
    {title: 'ボラティリティが高い通貨', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.png"), filename:"sample-post3.png"), body: 'ボラティリティとは、価格変動の度合いを示す言葉でボラティリティーが高いということは一般的に価格変動が大きいということを示す。反対にボラティリティーが低いと価格変動が小さい。AUDJPY,NZDJPY,AUDUSD,CADJPY,AUDGBPがボラティリティーが高い通貨ペアと言われている。', user_id: users[2].id }
  ]
)


