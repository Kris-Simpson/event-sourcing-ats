FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Job.field }
  end
end
