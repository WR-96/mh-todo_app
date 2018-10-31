class WeeklyMailerPreview < ActionMailer::Preview
  def weekly_report
    WeeklyMailer.weekly_report(User.first)
  end
end
