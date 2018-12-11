FactoryBot.define do
  factory :webmention, class: ::FrancisCms::Webmention do
    source { ::Faker::Internet.url }
    target { ::Faker::Internet.url }
    title { ::SecureRandom.hex }
  end
end
