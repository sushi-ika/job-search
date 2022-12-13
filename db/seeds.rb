# ユーザー登録
User.find_or_create_by!(email: 'admin@example.com') do |user|
    user.last_name = '管理者'
    user.first_name = '太郎'
    user.last_name_kana = 'カンリシャ'
    user.first_name_kana = 'タロウ'
    user.number = '09000000001'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = true
    user.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/photo.jpg')),
    filename: 'photo.jpg')
end
User.find_or_create_by!(email: 'user_yamada@example.com') do |user|
    user.last_name = '山田'
    user.first_name = '次郎'
    user.last_name_kana = 'ヤマダ'
    user.first_name_kana = 'ジロウ'
    user.number = '09000000002'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = false
    user.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/photo.jpg')),
    filename: 'photo.jpg')
end
User.find_or_create_by!(email: 'user_tanaka@example.com') do |user|
    user.last_name = '田中'
    user.first_name = '三郎'
    user.last_name_kana = 'タナカ'
    user.first_name_kana = 'サブロウ'
    user.number = '09000000003'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = false
    user.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/photo.jpg')),
    filename: 'photo.jpg')
end
User.find_or_create_by!(email: 'user_suzuki@example.com') do |user|
    user.last_name = '鈴木'
    user.first_name = '四郎'
    user.last_name_kana = 'スズキ'
    user.first_name_kana = 'シロウ'
    user.number = '09000000004'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = false
    user.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/photo.jpg')),
    filename: 'photo.jpg')
end
User.find_or_create_by!(email: 'user_satou@example.com') do |user|
    user.last_name = '佐藤'
    user.first_name = '五郎'
    user.last_name_kana = 'サトウ'
    user.first_name_kana = 'ゴロウ'
    user.number = '09000000005'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = false
    user.profile_picture.attach(io: File.open(Rails.root.join('app/assets/images/photo.jpg')),
    filename: 'photo.jpg')
end
User.find_or_create_by!(email: 'user_saitou@example.com') do |user|
    user.last_name = '加藤'
    user.first_name = '花子'
    user.last_name_kana = 'サイトウ'
    user.first_name_kana = 'ハナコ'
    user.number = '09000000006'
    user.postcode = 1111111
    user.prefecture_code = 13
    user.address_city = '豊島区'
    user.address_street = '池袋'
    user.station = '池袋駅'
    user.birthday = Date.today
    user.password = 'password2'
    user.password_confirmation = 'password2'
    user.gender = 'male'
    user.admin = false

end


# イベント登録
60.times do |n|
    random = Random.new(88)
    places = ['東京ドーム','埼玉スーパーアリーナ','代々木第一体育館','横浜アリーナ']
    descriptions = ['搬入','搬出','イベント運営','グッズ販売']
    unless (n % 4 == 0 or n % 9 == 0)
        Event.create!(
            title: "サンプル#{n + 1}",
            description: descriptions.sample,
            wages: 1000,
            start: DateTime.now.beginning_of_day + (n - 29).day - 14.hour,
            end: DateTime.now.beginning_of_day + (n - 29).day - 14.hour + 8.hour,
            limit: 5,
            deadline: DateTime.now.beginning_of_day + (n - 30).day,
            place: places.sample,
            allowance: 2000,
            remark: 'なし'
        )
    else
        Event.create!(
            title: "サンプル#{n + 1}",
            description: descriptions[random.rand(3)],
            wages: 1000,
            start: DateTime.now.beginning_of_day + (n - 28).day - 14.hour,
            end: DateTime.now.beginning_of_day + (n - 28).day - 14.hour + 8.hour,
            limit: 5,
            deadline: DateTime.now.beginning_of_day + (n - 29).day,
            place: places[random.rand(2)],
            allowance: 2000,
            remark: 'なし'
        )
    end
end

# idを中間テーブルに登録
for i in 2..6 do
    for j in 1..60 do
        if j % (i + 1) == 0 
            @event = Event.find(j)
            if @event.deadline < DateTime.now
                EventApplicant.create(applicant_id: i, event_id: j, begin: @event.start ,finish: @event.end) 
            else
                EventApplicant.create(applicant_id: i, event_id: j) 
            end
        end
    end
end

# News登録
10.times do |n|
    if n == 9
        News.create!(
            title: "[News]当社ウェブサイトをリニューアルいたしました。",
            text: "この度、お客様ににより快適にご利用いただけるよう、ページ構成ならびにサイトデザインの見直しを実施いたしました。\n
            今後も、よりいっそう内容を充実させると共に、利便性の向上に努めてまいります。\n
            一層のご愛顧を賜りますようよろしくお願いいたします。"
        )
    else
        News.create!(
            title: "ニュースその#{n+1}",
            text: "1行目\n2行目\n3行目"
        )    
    end
end
