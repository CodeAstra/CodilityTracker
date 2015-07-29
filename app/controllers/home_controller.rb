class HomeController < ApplicationController
  # Generated using:
  #   `rails g controller home land`
  def land
  end

  def dashboard
    @submissions = current_user.submissions.order(id: :desc).all
    @pending_submission_ids = @submissions.reject(&:scraped?).select(&:id)
    @new_submission = current_user.submissions.new
  end
end
