class Events::JobApplication::Interview < Events::JobApplication::BaseEvent
  data_attributes :interview_date

  def apply(job_application)
    job_application
  end
end
