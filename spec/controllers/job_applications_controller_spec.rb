require "rails_helper"

RSpec.describe JobApplicationsController, type: :controller do
  describe "GET #index" do
    let(:deactivated_job) { create(:job) }
    let(:activated_job) { create(:job) }
    let(:job1_hired_application) { create(:job_application, job: deactivated_job) }
    let(:job2_hired_application) { create(:job_application, job: activated_job) }
    let(:job2_rejected_application) { create(:job_application, job: activated_job) }
    let(:job2_ongoing_application) { create(:job_application, job: activated_job) }
    let(:last_interview_date) { 1.day.ago }

    before do
      create(:job_activated_event, job: deactivated_job)
      create(:job_deactivated_event, job: deactivated_job)
      create(:job_activated_event, job: activated_job)

      create(:job_application_hired_event, job_application: job1_hired_application)
      create(:job_application_hired_event, job_application: job2_hired_application)
      create(:job_application_rejected_event, job_application: job2_rejected_application)
      create(:job_application_note_event, job_application: job2_rejected_application, data: { note: "Some note" })
      create(:job_application_interview_event, job_application: job2_ongoing_application, data: { interview_date: last_interview_date })
    end

    it "renders a JSON response with all jobs" do
      get :index

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)
      expect(json_response.dig("job_applications").length).to eq(3)
      expect(json_response.dig("job_applications", 0, "status")).to eq("hired")
      expect(json_response.dig("job_applications", 1, "status")).to eq("rejected")
      expect(json_response.dig("job_applications", 1, "notes_count")).to eq(1)
      expect(json_response.dig("job_applications", 2, "status")).to eq("interview")
      expect(json_response.dig("job_applications", 2, "last_interview_date").to_date).to eq(last_interview_date.to_date)
    end
  end
end
