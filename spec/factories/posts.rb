FactoryBot.define do
  factory :post, class: ::FrancisCms::Post do
    body { ::Faker::Markdown.random }
    title { ::SecureRandom.hex }
  end
end
