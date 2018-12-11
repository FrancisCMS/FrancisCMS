FactoryBot.define do
  factory :tag, class: ::FrancisCms::Link do
    url { ::Faker::Internet.url }
    title { ::SecureRandom.hex }
    body { ::Faker::Markdown.random }
  end
end
