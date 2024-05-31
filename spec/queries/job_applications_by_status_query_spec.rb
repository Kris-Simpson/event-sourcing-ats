require "rails_helper"

RSpec.describe JobApplicationsByStatusQuery do
  subject(:query) { described_class.new }

  describe "#hired" do
    let(:job_application1) { create(:job_application) }
    let(:job_application2) { create(:job_application) }

    before do
      create(:job_application_hired_event, job_application: job_application1)
      create(:job_application_hired_event, job_application: job_application2)
      create(:job_application_rejected_event, job_application: job_application2)
    end

    it "returns job applications with last event type 'Events::JobApplication::Hired'" do
      result = query.hired

      expect(result).to include(job_application1)
      expect(result).not_to include(job_application2)
      expect(result.size).to eq(1)
    end
  end

  describe "#rejected" do
    let(:job_application1) { create(:job_application) }
    let(:job_application2) { create(:job_application) }

    before do
      create(:job_application_interview_event, job_application: job_application1)
      create(:job_application_rejected_event, job_application: job_application1)
      create(:job_application_hired_event, job_application: job_application2)
    end

    it "returns job applications with last event type 'Events::JobApplication::Rejected'" do
      result = query.rejected

      expect(result).to include(job_application1)
      expect(result).not_to include(job_application2)
      expect(result.size).to eq(1)
    end
  end

  describe "#ongoing" do
    let(:job_application1) { create(:job_application) }
    let(:job_application2) { create(:job_application) }
    let(:job_application3) { create(:job_application) }

    before do
      create(:job_application_hired_event, job_application: job_application1)
      create(:job_application_rejected_event, job_application: job_application2)
      create(:job_application_interview_event, job_application: job_application3)
    end

    it "returns job applications with the 'ongoing' status" do
      result = query.ongoing

      expect(result).not_to include(job_application1)
      expect(result).not_to include(job_application2)
      expect(result).to include(job_application3)
      expect(result.size).to eq(1)
    end
  end
end
