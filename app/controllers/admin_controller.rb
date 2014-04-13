class AdminController < ApplicationController
  before_action :ensure_is_admin

  def index
  end

  def hours_by_developer
    @results = Event.
      select("-1 * sum(amount) as total, name").
      joins(:user).
      where("amount < 0").
      group("user_id, name").
      order("name").to_a
  end

  def hours_by_developer_by_project
    @results = Project.
      select("-1 * sum(amount) as total, users.name, title").
      joins(:users).
      joins("LEFT JOIN events ON projects.id = events.project_id AND users.id = events.user_id AND events.amount < 0").
      where("users.is_admin = ?", true).
      group("users.id, projects.id, users.name, projects.title").
      order("users.name, title").to_a
  end

  def weekly_monthly_hours
    @this_weeks_hours = Project.
      select("-1 * sum(amount) as total, users.id, users.name").
      joins(:users).
      joins("LEFT JOIN events ON projects.id = events.project_id AND users.id = events.user_id AND events.amount < 0").
      where("users.is_admin = ? AND events.done_on >= ? AND events.done_on < ?", true, Date.today.at_beginning_of_week, Date.today.next_week.at_beginning_of_week).
      group("users.id, users.name").
      order("users.name").to_a

    raw_events = Event.
      select("users.id, users.name, events.done_on, -1 * events.amount as amount").
      joins(:user).
      where("users.is_admin = ? AND events.amount < 0 AND events.done_on >= ? AND events.done_on < ?", true, Date.today.at_beginning_of_year, Date.today.next_year.at_beginning_of_year).
      order("users.name").to_a

    @month_hours_by_dev = {}
    @months = (1..12).to_a
    @devs = []

    raw_events.each do |event|
      dev = event.name
      month = event.done_on.month
      @devs << dev

      @month_hours_by_dev[dev] = {} if @month_hours_by_dev[dev].nil?
      @month_hours_by_dev[dev][month] = 0 if @month_hours_by_dev[dev][month].nil?
      @month_hours_by_dev[dev][month] += event.amount
    end

    @devs.uniq!.sort!
  end

  private

  def ensure_is_admin
    if !current_user || ! current_user.is_admin
      redirect_to root_path, alert: 'You must be an admin user to perform these operations'
    end
  end
end
