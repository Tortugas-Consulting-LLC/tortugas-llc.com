class EventsController < ApplicationController
  before_action :set_project
  before_action :set_event, only: [:edit, :update, :destroy]
  before_action :ensure_logged_in
  before_action :ensure_is_admin, only: [:edit, :update, :destroy]

  def edit
  end

  def destroy
    respond_to do |format|
      @event.destroy
      format.html { redirect_to @project }
      format.json { head :no_content }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.project = @project
    @event.user = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @project, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @project, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params[:event].permit(:for, :description, :amount)
    end

    def ensure_logged_in
      if ! user_signed_in?
        redirect_to new_user_session_path, alert: 'You must be logged in to view events'
      end
    end

    def ensure_is_admin
      if ! current_user.is_admin
        redirect_to projects_path, alert: 'You must be an admin user to perform these operations'
      end
    end

end
