class JobsByStatusQuery
  def initialize(relation = Job.all)
    @relation = relation
  end

  def activated
    joins.where(events: { type: Events::Job::BaseEvent::ACTIVATED_TYPE })
  end

  private

  attr_reader :relation

  # Joins the `jobs` table with a subquery that retrieves the last events for each job.
  # Then joins the `job_events` table to filter the events based on the last event time and the event type.
  def joins
    relation
      .joins("JOIN (#{last_events_subquery.to_sql}) AS last_events \
              ON jobs.id = last_events.job_id")
      .joins("JOIN job_events as events \
              ON last_events.job_id = events.job_id \
              AND last_events.last_event_time = events.created_at")
  end

  # Returns a subquery that selects the last event for each Job.
  def last_events_subquery
    Events::Job::BaseEvent.select(:job_id, "MAX(created_at) AS last_event_time")
                          .group(:job_id)
  end
end
