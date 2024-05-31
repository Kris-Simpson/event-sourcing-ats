class Job < ApplicationRecord
  STATUS_MAPPINGS = {
    nil => "deactivated",
    "Events::Job::Activated" => "activated",
    "Events::Job::Deactivated" => "deactivated"
  }.freeze

  has_many :job_applications
  has_many :events, class_name: "Events::Job::BaseEvent"

  validates :title, presence: true

  scope :activated, -> { JobsByStatusQuery.new(self).activated }

  def status
    STATUS_MAPPINGS[events.last&.type]
  end
end
