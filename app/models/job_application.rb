class JobApplication < ApplicationRecord
  STATUSES = [
    APPLIED = "applied".freeze,
    INTERVIEW = "interview".freeze,
    HIRED = "hired".freeze,
    REJECTED = "rejected".freeze
  ].freeze
  STATUS_MAPPINGS = {
    nil => APPLIED,
    "Events::JobApplication::Interview" => INTERVIEW,
    "Events::JobApplication::Hired" => HIRED,
    "Events::JobApplication::Rejected" => REJECTED
  }.freeze

  belongs_to :job
  has_many :events, class_name: "Events::JobApplication::BaseEvent"

  validates :candidate_name, presence: true

  scope :hired, -> { JobApplicationsByStatusQuery.new(self).hired }
  scope :rejected, -> { JobApplicationsByStatusQuery.new(self).rejected }
  scope :ongoing, -> { JobApplicationsByStatusQuery.new(self).ongoing }

  def status
    STATUS_MAPPINGS[events.without_notes.last&.type]
  end
end
