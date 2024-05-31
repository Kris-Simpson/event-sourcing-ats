module Events
  module Job
    class Deactivated < Events::Job::BaseEvent
      def apply(job)
        job
      end
    end
  end
end
