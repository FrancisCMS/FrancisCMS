FactoryBot.define do
  factory :link, class: ::FrancisCms::Link do
    url { ::Faker::Internet.url }
    title { ::SecureRandom.hex }
    body { ::Faker::Markdown.random }
  end
end
