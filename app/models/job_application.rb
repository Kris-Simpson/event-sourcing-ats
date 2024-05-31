class JobApplication < ApplicationRecord
  STATUSES = [
    APPLIED = "applied",
    INTERVIEW = "interview",
    HIRED = "hired",
    REJECTED = "rejected"
  ]
  STATUS_MAPPINGS = {
    nil => APPLIED,
    "Events::JobApplication::Interview" => INTERVIEW,
    "Events::JobApplication::Hired" => HIRED,
    "Events::JobApplication::Rejected" => REJECTED
  }.freeze

  belongs_to :job
  has_many :events, class_name: "Events::JobApplication::BaseEvent"

  validates :candidate_name, presence: true

  scope :hired, -> { JobApplicationsByStatusQuery.new(status: HIRED).call }
  scope :rejected, -> { JobApplicationsByStatusQuery.new(status: REJECTED).call }
  scope :ongoing, -> { hired.invert_where.and(rejected.invert_where) }

  def status
    STATUS_MAPPINGS[events.without_notes.last&.type]
  end
end
