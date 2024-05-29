class JobApplication < ApplicationRecord
  belongs_to :job

  validates :candidate_name, presence: true
end
