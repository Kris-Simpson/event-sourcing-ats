class Job < ApplicationRecord
  has_many :applications, class_name: "JobApplication"

  validates :title, presence: true
end
