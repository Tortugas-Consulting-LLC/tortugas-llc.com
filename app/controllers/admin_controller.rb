class AdminController < ApplicationController
  def index
  end

  def projects
    @projects = Project.all
  end

  def create_project
  end
end
