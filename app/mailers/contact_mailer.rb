class ContactMailer < ActionMailer::Base
  default from: "Website Submission Form <webmail@tortugas-llc.com>"

  def contact_us_email(options)
      @name = options[:name]
      @email = options[:email]
      @message = options[:message]
      mail(to: "projects@tortugas-llc.com", subject: "Website Submission :: " + options[:subject].to_s())
  end
end
