require "rails_helper"

RSpec.describe JobsByStatusQuery do
  subject(:query) { described_class.new }

  describe "#activated" do
    let(:job1) { create(:job) }
    let(:job2) { create(:job) }

    before do
      create(:job_activated_event, job: job1)
      create(:job_activated_event, job: job2)
      create(:job_deactivated_event, job: job2)
    end

    it "returns jobs with last event type 'Events::Job::Activated'" do
      result = query.activated

      expect(result).to include(job1)
      expect(result).not_to include(job2)
      expect(result.size).to eq(1)
    end
  end
end
