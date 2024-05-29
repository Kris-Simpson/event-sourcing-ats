class JobApplication < ApplicationRecord
  belongs_to :job
  has_many :events, class_name: "Events::JobApplication::BaseEvent"

  validates :candidate_name, presence: true
end
