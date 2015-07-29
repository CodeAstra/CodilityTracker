class HomeController < ApplicationController
  # Generated using:
  #   `rails g controller home land`
  def land
  end

  def dashboard
    @submissions = current_user.submissions.all
    @new_submission = current_user.submissions.new
  end
end
