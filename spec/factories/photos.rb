FactoryBot.define do
  factory :photo, class: ::FrancisCms::Photo do
    photo do
      ::File.open(
        File.join(
          ActionDispatch::IntegrationTest.fixture_path,
          'photo.jpg'
        )
      )
    end
  end
end
