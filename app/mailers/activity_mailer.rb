class ActivityMailer < ActionMailer::Base
  default from: "from@example.com"

  def activity_email(subject)
    @activity = subject
    @url  = 'http://example.com/login'
    # mail(to: @activity.user.email, subject: "You've got a dumb activity")
  end



end
