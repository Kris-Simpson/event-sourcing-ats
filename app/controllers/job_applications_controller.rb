class JobApplicationsController < ActionController::API
  def index
    job_applications = JobApplication.includes(:job).joins(:job).merge(Job.activated)

    render json: JobApplicationBlueprint.render_as_json(job_applications, root: :job_applications)
  end
end
