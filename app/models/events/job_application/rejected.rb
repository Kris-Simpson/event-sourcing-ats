module Events
  module JobApplication
    class Rejected < Events::JobApplication::BaseEvent
      def apply(job_application)
        job_application
      end
    end
  end
end
