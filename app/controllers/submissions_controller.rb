class SubmissionsController < ApplicationController
  def create
    @submission = current_user.submissions.new(submission_params)
    @save_success = @submission.save
  end

private
  def submission_params
    params.require(:submission).permit(:url)
  end
end
