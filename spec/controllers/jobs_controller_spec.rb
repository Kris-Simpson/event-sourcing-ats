require "rails_helper"

RSpec.describe JobsController, type: :controller do
  describe "GET #index" do
    let(:deactivated_job) { create(:job) }
    let(:activated_job) { create(:job) }
    let(:job1_hired_application) { create(:job_application, job: deactivated_job) }
    let(:job2_hired_application) { create(:job_application, job: activated_job) }
    let(:job2_rejected_application) { create(:job_application, job: activated_job) }
    let(:job2_ongoing_application) { create(:job_application, job: activated_job) }

    before do
      create(:job_activated_event, job: deactivated_job)
      create(:job_deactivated_event, job: deactivated_job)
      create(:job_activated_event, job: activated_job)

      create(:job_application_hired_event, job_application: job1_hired_application)
      create(:job_application_hired_event, job_application: job2_hired_application)
      create(:job_application_rejected_event, job_application: job2_rejected_application)
      create(:job_application_note_event, job_application: job2_rejected_application, data: { note: "Some note" })
      create(:job_application_interview_event, job_application: job2_ongoing_application, data: { interview_date: 1.day.ago })
    end

    it "renders a JSON response with all jobs" do
      get :index

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response.dig("jobs").length).to eq(2)
      expect(json_response.dig("jobs", 0, "hired_applications_count")).to eq(1)
      expect(json_response.dig("jobs", 1, "hired_applications_count")).to eq(1)
      expect(json_response.dig("jobs", 1, "rejected_applications_count")).to eq(1)
      expect(json_response.dig("jobs", 1, "ongoing_applications_count")).to eq(1)
    end
  end
end
