class Events::Job::BaseEvent < Events::BaseEvent
  self.table_name = "job_events"

  belongs_to :job, class_name: "::Job", autosave: false
end
