class HomeController < ApplicationController
  # Generated using:
  #   `rails g controller home land`
  def land
  end

  def dashboard
    @new_submission = Submission.new
  end
end
