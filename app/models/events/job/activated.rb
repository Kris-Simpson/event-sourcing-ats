module Events
  module Job
    class Activated < Events::Job::BaseEvent
      def apply(job)
        job
      end
    end
  end
end
