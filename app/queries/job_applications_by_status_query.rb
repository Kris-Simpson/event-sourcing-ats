class JobApplicationsByStatusQuery
  def initialize(relation = JobApplication.all)
    @relation = relation
  end

  def hired
    joins.where(events: { type: Events::JobApplication::BaseEvent::HIRED_TYPE })
  end

  def rejected
    joins.where(events: { type: Events::JobApplication::BaseEvent::REJECTED_TYPE })
  end

  def ongoing
    joins.where.not(events: { type: [Events::JobApplication::BaseEvent::HIRED_TYPE,
                                     Events::JobApplication::BaseEvent::REJECTED_TYPE] })
  end

  private

  attr_reader :relation

  # Joins the `job_applications` table with a subquery that retrieves the last events for each job application.
  # Then joins the `job_application_events` table to filter the events based on the last event time and the event type.
  def joins
    relation
      .joins("JOIN (#{last_events_subquery.to_sql}) AS last_events \
              ON job_applications.id = last_events.job_application_id")
      .joins("JOIN job_application_events as events \
              ON last_events.job_application_id = events.job_application_id \
              AND last_events.last_event_time = events.created_at")
  end

  # Returns a subquery that selects the last event for each JobApplication, excluding Note events.
  def last_events_subquery
    Events::JobApplication::BaseEvent.select(:job_application_id, "MAX(created_at) AS last_event_time")
                                     .where.not(type: Events::JobApplication::BaseEvent::NOTE_TYPE)
                                     .group(:job_application_id)
  end
end
