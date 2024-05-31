FactoryBot.define do
  factory :job_activated_event, class: Events::Job::Activated do
    job
    type { "Events::Job::Activated" }
    data { {} }
  end

  factory :job_deactivated_event, class: Events::Job::Deactivated do
    job
    type { "Events::Job::Deactivated" }
    data { {} }
  end

  factory :job_application_interview_event, class: Events::JobApplication::Interview do
    job_application
    type { "Events::JobApplication::Interview" }
    data { { interview_date: Time.now } }
  end

  factory :job_application_hired_event, class: Events::JobApplication::Hired do
    job_application
    type { "Events::JobApplication::Hired" }
    data { { hire_date: Time.now } }
  end

  factory :job_application_rejected_event, class: Events::JobApplication::Rejected do
    job_application
    type { "Events::JobApplication::Rejected" }
    data { {} }
  end

  factory :job_application_note_event, class: Events::JobApplication::Note do
    job_application
    type { "Events::JobApplication::Note" }
    data { { note: Faker::Lorem.sentence } }
  end
end
