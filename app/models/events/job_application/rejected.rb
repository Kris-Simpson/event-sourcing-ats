class Events::JobApplication::Rejected < Events::JobApplication::BaseEvent
  def apply(job_application)
    job_application
  end
end
