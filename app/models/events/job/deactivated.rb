class Events::Job::Deactivated < Events::Job::BaseEvent
  def apply(job)
    job
  end
end
