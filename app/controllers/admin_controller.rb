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
      where("users.is_admin = true").
      group("users.id, projects.id, users.name, projects.title").
      order("users.name, title").to_a
  end

  private

  def ensure_is_admin
    if ! current_user.is_admin
      redirect_to root_path, alert: 'You must be an admin user to perform these operations'
    end
  end
end
