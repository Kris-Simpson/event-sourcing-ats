class Events::JobApplication::BaseEvent < Events::BaseEvent
  self.table_name = "job_application_events"

  INTERVIEW_TYPE = "Events::JobApplication::Interview"
  HIRED_TYPE = "Events::JobApplication::Hired"
  REJECTED_TYPE = "Events::JobApplication::Rejected"
  NOTE_TYPE = "Events::JobApplication::Note"

  belongs_to :job_application, class_name: "::JobApplication", autosave: false

  scope :interviews, -> { where(type: INTERVIEW_TYPE) }
  scope :notes, -> { where(type: NOTE_TYPE) }
  scope :without_notes, -> { where.not(type: NOTE_TYPE) }
end
