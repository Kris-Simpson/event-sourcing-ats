module Events
  module JobApplication
    class BaseEvent < Events::BaseEvent
      self.table_name = "job_application_events"

      INTERVIEW_TYPE = "Events::JobApplication::Interview".freeze
      HIRED_TYPE = "Events::JobApplication::Hired".freeze
      REJECTED_TYPE = "Events::JobApplication::Rejected".freeze
      NOTE_TYPE = "Events::JobApplication::Note".freeze

      belongs_to :job_application, class_name: "::JobApplication", autosave: false

      scope :interviews, -> { where(type: INTERVIEW_TYPE) }
      scope :notes, -> { where(type: NOTE_TYPE) }
      scope :without_notes, -> { where.not(type: NOTE_TYPE) }
    end
  end
end
