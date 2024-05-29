class Job < ApplicationRecord
  has_many :job_applications
  has_many :events, class_name: "Events::Job::BaseEvent"

  validates :title, presence: true
end
