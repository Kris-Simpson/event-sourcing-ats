class JobsController < ActionController::API
  def index
    render json: JobBlueprint.render_as_json(Job.all, root: :jobs)
  end
end
