module Events
  module JobApplication
    class Hired < Events::JobApplication::BaseEvent
      data_attributes :hire_date

      def apply(job_application)
        job_application
      end
    end
  end
end
