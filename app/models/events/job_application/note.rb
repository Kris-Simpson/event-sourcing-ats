module Events
  module JobApplication
    class Note < Events::JobApplication::BaseEvent
      data_attributes :note

      def apply(job_application)
        job_application
      end
    end
  end
end
