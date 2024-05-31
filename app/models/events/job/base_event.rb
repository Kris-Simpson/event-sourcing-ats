class Events::Job::BaseEvent < Events::BaseEvent
  self.table_name = "job_events"

  ACTIVATED_TYPE = "Events::Job::Activated"
  DEACTIVATED_TYPE = "Events::Job::Deactivated"

  belongs_to :job, class_name: "::Job", autosave: false
end
