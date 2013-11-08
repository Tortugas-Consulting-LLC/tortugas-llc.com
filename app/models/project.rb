class Project < ActiveRecord::Base
  has_many :users, :through => :projects_users
  has_many :projects_users
  has_many :events

  def balance
    Event.where(project: self).sum('amount')
  end

  def balance_as_of event
    # Finds the balance at the end of the application of a particular event.
    # This assumes that events are applied to your balance in date order and,
    # in the case of multiple events on the same day, in primary key order
    sql = "
      project_id = :project AND (
        done_on < :done_on OR
        id = :event OR (
          done_on = :done_on AND id < :event
        )
      )";
    query_params = {
      project: self.id,
      done_on: event.done_on,
      event: event.id
    }
    Event.where(sql, query_params).sum('amount')
  end
end
