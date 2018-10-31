class WeeklyMailer < ApplicationMailer
  layout 'mailer'
  def weekly_report(user)
    @user = user
    mail(to: @user.email, subject: 'Weekly report')
  end
end
