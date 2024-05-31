job = Job.create!(title: "job")

job_application1 = JobApplication.create!(job: job, candidate_name: "candidate1")
job_application2 = JobApplication.create!(job: job, candidate_name: "candidate2")
job_application3 = JobApplication.create!(job: job, candidate_name: "candidate3")
job_application4 = JobApplication.create!(job: job, candidate_name: "candidate4")
job_application5 = JobApplication.create!(job: job, candidate_name: "candidate5")

Events::JobApplication::Interview.create!(job_application: job_application1)
Events::JobApplication::Hired.create!(job_application: job_application1)

Events::JobApplication::Interview.create!(job_application: job_application2)
Events::JobApplication::Note.create!(job_application: job_application2, note: "some note")
Events::JobApplication::Rejected.create!(job_application: job_application2)
Events::JobApplication::Note.create!(job_application: job_application2, note: "some second note")

Events::JobApplication::Interview.create!(job_application: job_application3)
Events::JobApplication::Note.create!(job_application: job_application3, note: "some note")
Events::JobApplication::Hired.create!(job_application: job_application3)
Events::JobApplication::Note.create!(job_application: job_application3, note: "some second note")

Events::JobApplication::Interview.create!(job_application: job_application4)
Events::JobApplication::Rejected.create!(job_application: job_application4)

Events::JobApplication::Interview.create!(job_application: job_application5)
Events::JobApplication::Note.create!(job_application: job_application5, note: "some note")
