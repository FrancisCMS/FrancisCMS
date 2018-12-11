FactoryBot.define do
  factory :syndication, class: ::FrancisCms::Syndication do
    url { ::Faker::Internet.url }
    name { ::Faker::Internet.domain_name }
  end
end
