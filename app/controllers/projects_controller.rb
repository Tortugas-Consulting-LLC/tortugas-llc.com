class ProjectsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_is_admin, only: [:edit, :update, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :grab_users, only: [:edit, :new]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all.order("title")
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @events = Event.where(project: @project).order('done_on desc', :user_id, :description).page(params[:page]).per(25)
    @total = Event.where(project: @project).sum('amount')
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    respond_to do |format|
      if 0 == @project.events.count
        @project.destroy
        format.html { redirect_to projects_url }
        format.json { head :no_content }
      else
        format.html { redirect_to projects_url, alert: 'This project has events associated with it and cannot be deleted' }
        format.json { head :no_content, status: :unprocessable_entity }
      end
    end
  end

  private
    def ensure_logged_in
      if ! user_signed_in?
        redirect_to new_user_session_path, alert: 'You must be logged in to view projects'
      end
    end

    def ensure_is_admin
      if ! current_user.is_admin
        redirect_to projects_path, alert: 'You must be an admin user to perform these operations'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params[:project].permit(:title, :description, :user_ids => [])
    end

    def grab_users
      @users = User.order(:name)
    end
end
