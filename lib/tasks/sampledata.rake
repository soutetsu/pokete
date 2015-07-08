namespace :sampledata do
  desc 'create sample data'

  DUMMY_TAGS = %w{
    foo
    bar
    baz
    hoge
    fuga
  }.freeze

  DUMMY_IMAGES = %w{
    400x300-1.jpeg
    400x300-2.jpeg
    400x300-3.jpeg
    400x300-4.jpeg
    400x300-5.jpeg
  }.freeze

  task create: :environment do
    create_users
    create_themes
    create_bokes
  end

  def create_users
    User.create!(email: 'soutetsu@gmail.com', password: 'xxx')
    User.create!(email: 'dev.tetsu@gmail.com', password: 'xxx')
  end

  def create_themes
    10.times do
      User.all.sample.themes.create!(category_id: Category.all.sample.id, uri: DUMMY_IMAGES.sample)
    end
  end

  def create_bokes
    20.times do
      User.all.sample.bokes.create!(theme_id: Theme.all.sample.id, content: Faker::Lorem.sentence)
    end
    Boke.all.each do |boke|
      boke.tag_list.add(DUMMY_TAGS.sample(2))
      boke.save!
      User.all.each do |user|
        boke.evaluations.create!(user_id: user.id, point: [*1..3].sample, comment: Faker::Lorem.paragraph)
      end
    end
  end
end
