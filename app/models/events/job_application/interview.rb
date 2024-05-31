module Events
  module JobApplication
    class Interview < Events::JobApplication::BaseEvent
      data_attributes :interview_date

      def apply(job_application)
        job_application
      end
    end
  end
end
