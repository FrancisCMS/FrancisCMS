FactoryBot.define do
  factory :webmention, class: ::FrancisCms::Webmention do
    source { ::Faker::Internet.url }
    target { ::FrancisCms.configuration.site_url.sub(/^https?:/, 'https:') }
  end
end
