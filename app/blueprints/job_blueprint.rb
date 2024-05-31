class JobBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :status

  field :hired_applications_count do |object|
    object.job_applications.hired.count
  end

  field :rejected_applications_count do |object|
    object.job_applications.rejected.count
  end

  field :ongoing_applications_count do |object|
    object.job_applications.ongoing.count
  end
end
