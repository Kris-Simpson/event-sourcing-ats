require "rails_helper"

RSpec.describe Job, type: :model do
  subject(:job) { create(:job) }

  describe "associations" do
    it { is_expected.to have_many(:job_applications) }
    it { is_expected.to have_many(:events) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.not_to validate_presence_of(:description) }
  end

  describe "#status" do
    context "when there are no events" do
      it "returns 'deactivated'" do
        expect(job.status).to eq("deactivated")
      end
    end

    context "when the last event is 'Events::Job::Activated'" do
      before do
        create(:job_deactivated_event, job: job)
        create(:job_activated_event, job: job)
      end

      it "returns 'activated'" do
        expect(job.status).to eq("activated")
      end
    end

    context "when the last event is 'Events::Job::Deactivated'" do
      before do
        create(:job_activated_event, job: job)
        create(:job_deactivated_event, job: job)
      end

      it "returns 'deactivated'" do
        expect(job.status).to eq("deactivated")
      end
    end
  end
end
