class Events::Job::Activated < Events::Job::BaseEvent
  def apply(job)
    job
  end
end
