class JobApplication < ApplicationRecord
  STATUS_MAPPINGS = {
    nil => "applied",
    "Events::JobApplication::Interview" => "interview",
    "Events::JobApplication::Hired" => "hired",
    "Events::JobApplication::Rejected" => "rejected"
  }.freeze

  belongs_to :job
  has_many :events, class_name: "Events::JobApplication::BaseEvent"

  validates :candidate_name, presence: true

  def status
    STATUS_MAPPINGS[events.without_notes.last&.type]
  end
end
