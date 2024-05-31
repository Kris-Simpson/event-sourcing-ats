FactoryBot.define do
  factory :job_application do
    job
    candidate_name { Faker::Name.name }
  end
end
