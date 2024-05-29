class Events::JobApplication::Hired < Events::JobApplication::BaseEvent
  data_attributes :hire_date

  def apply(job_application)
    job_application
  end
end
