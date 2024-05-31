old_job     = Job.create!(title: "Old job that is already deactivated")
ongoing_job = Job.create!(title: "Ongoing job that is currently active")
_new_job    = Job.create!(title: "New job that was created recently but not activated yet")

Events::Job::Activated.create!(job: old_job)
Events::Job::Deactivated.create!(job: old_job)
Events::Job::Activated.create!(job: ongoing_job)

old_job_application1  = JobApplication.create!(job: old_job, candidate_name: "old candidate1")
_old_job_application2 = JobApplication.create!(job: old_job, candidate_name: "old candidate2")

ongoing_job_application1  = JobApplication.create!(job: ongoing_job, candidate_name: "ongoing candidate1")
ongoing_job_application2  = JobApplication.create!(job: ongoing_job, candidate_name: "ongoing candidate2")
ongoing_job_application3  = JobApplication.create!(job: ongoing_job, candidate_name: "ongoing candidate3")
ongoing_job_application4  = JobApplication.create!(job: ongoing_job, candidate_name: "ongoing candidate4")
ongoing_job_application5  = JobApplication.create!(job: ongoing_job, candidate_name: "ongoing candidate5")
_ongoing_job_application6 = JobApplication.create!(job: ongoing_job, candidate_name: "ongoing candidate6")

# old candidate1 | HIRED
Events::JobApplication::Interview.create!(job_application: old_job_application1, interview_date: 1.year.ago - 1.week)
Events::JobApplication::Hired.create!(job_application: old_job_application1, hire_date: 1.year.ago)

# ongoing candidate1 | REJECTED with notes
Events::JobApplication::Interview.create!(job_application: ongoing_job_application1, interview_date: 1.month.ago)
Events::JobApplication::Note.create!(job_application: ongoing_job_application1, note: "some note")
Events::JobApplication::Rejected.create!(job_application: ongoing_job_application1)
Events::JobApplication::Note.create!(job_application: ongoing_job_application1, note: "some other note")

# ongoing candidate2 | HIRED with notes
Events::JobApplication::Interview.create!(job_application: ongoing_job_application2, interview_date: 1.month.ago - 2.days)
Events::JobApplication::Note.create!(job_application: ongoing_job_application2, note: "some note")
Events::JobApplication::Hired.create!(job_application: ongoing_job_application2, hire_date: 1.month.ago)
Events::JobApplication::Note.create!(job_application: ongoing_job_application2, note: "some other note")

# ongoing candidate3 | REJECTED
Events::JobApplication::Interview.create!(job_application: ongoing_job_application3, interview_date: 3.weeks.ago)
Events::JobApplication::Rejected.create!(job_application: ongoing_job_application3)

# ongoing candidate4 | INTERVIEW with notes
Events::JobApplication::Interview.create!(job_application: ongoing_job_application4, interview_date: 2.weeks.ago)
Events::JobApplication::Note.create!(job_application: ongoing_job_application4, note: "some note")

# ongoing candidate5 | HIRED
Events::JobApplication::Interview.create!(job_application: ongoing_job_application5, interview_date: 9.days.ago)
Events::JobApplication::Hired.create!(job_application: ongoing_job_application5, hire_date: 1.week.ago)
