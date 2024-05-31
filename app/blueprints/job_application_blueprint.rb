class JobApplicationBlueprint < Blueprinter::Base
  identifier :id

  fields :candidate_name, :status

  field :job_title do |object|
    object.job.title
  end

  field :notes_count do |object|
    object.events.notes.count
  end

  field :last_interview_date do |object|
    object.events.interviews.last&.interview_date
  end
end
