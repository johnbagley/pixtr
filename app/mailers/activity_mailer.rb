class ActivityMailer < ActionMailer::Base
  default from: "from@example.com"

  def activity_email(user)
    @user = subject
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "You've got a dumb activity")
  end


end
