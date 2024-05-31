module Events
  module Job
    class BaseEvent < Events::BaseEvent
      self.table_name = "job_events"

      ACTIVATED_TYPE = "Events::Job::Activated".freeze
      DEACTIVATED_TYPE = "Events::Job::Deactivated".freeze

      belongs_to :job, class_name: "::Job", autosave: false
    end
  end
end
