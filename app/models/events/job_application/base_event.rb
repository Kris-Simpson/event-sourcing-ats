class Events::JobApplication::BaseEvent < Events::BaseEvent
  self.table_name = "job_application_events"

  belongs_to :job_application, class_name: "::JobApplication", autosave: false
end
