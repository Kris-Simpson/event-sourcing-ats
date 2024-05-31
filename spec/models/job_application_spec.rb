require "rails_helper"

RSpec.describe JobApplication, type: :model do
  subject(:job_application) { create(:job_application) }

  describe "associations" do
    it { is_expected.to belong_to(:job) }
    it { is_expected.to have_many(:events) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:candidate_name) }
  end

  describe "#status" do
    context "when there are no events" do
      it "returns 'applied'" do
        expect(job_application.status).to eq("applied")
      end
    end

    context "when there are no note events" do
      before do
        create(:job_application_interview_event, job_application: job_application)
        create(:job_application_rejected_event, job_application: job_application)
      end

      it "returns the status of the last event" do
        expect(job_application.status).to eq("rejected")
      end
    end

    context "when there are note events" do
      before do
        create(:job_application_interview_event, job_application: job_application)
        create(:job_application_hired_event, job_application: job_application)
        create(:job_application_note_event, job_application: job_application, data: { notes: "Great candidate!" })
      end

      it "returns the status of the last event ignoring note events" do
        expect(job_application.status).to eq("hired")
      end
    end
  end
end
