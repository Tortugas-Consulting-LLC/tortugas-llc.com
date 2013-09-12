class ContactController < ApplicationController
  def index
  end

  # POST /contact
  # POST /contact.json
  def send_email
    # Send email
    mail_options = {
      name: params[:name],
      email: params[:email],
      subject: params[:subject],
      message: params[:message]
    }
    ContactMailer.contact_us_email(mail_options).deliver

    # Redirect to index with notice
    respond_to do |format|
      format.html { redirect_to(:back, notice: 'Message succesfully sent.') }
      format.json { render json: :back, status: :created }
    end
  end
end
