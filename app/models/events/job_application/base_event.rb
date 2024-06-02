module Events
  module JobApplication
    class BaseEvent < Events::BaseEvent
      self.table_name = "job_application_events"

      belongs_to :job_application, class_name: "::JobApplication", autosave: false

      scope :interviews, -> { where(type: Interview.type) }
      scope :notes, -> { where(type: Note.type) }
      scope :without_notes, -> { where.not(type: Note.type) }
    end
  end
end
