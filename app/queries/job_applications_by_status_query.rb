class JobApplicationsByStatusQuery
  def initialize(relation = JobApplication.all, status:)
    @relation = relation
    @type = JobApplication::STATUS_MAPPINGS.key(status)
  end

  # Executes a database query to retrieve job applications based on their status.
  # It joins the `job_applications` table with a subquery that retrieves the last events for each job application.
  # Then it joins the `job_application_events` table to filter the events based on the last event time and the event type.
  # Finally, it applies a filter on the event type to retrieve job applications with a specific status.
  def call
    relation
      .joins("JOIN (#{last_events_subquery.to_sql}) AS last_events \
              ON job_applications.id = last_events.job_application_id")
      .joins("JOIN job_application_events as events \
              ON last_events.job_application_id = events.job_application_id \
              AND last_events.last_event_time = events.created_at")
      .where(events: { type: type })
  end

  private

  attr_reader :relation, :type

  # Returns a subquery that selects the last event for each JobApplication, excluding Note events.
  def last_events_subquery
    Events::JobApplication::BaseEvent.select(:job_application_id, "MAX(created_at) AS last_event_time")
                                     .where.not(type: "Events::JobApplication::Note")
                                     .group(:job_application_id)
  end
end
