class SubmissionsController < ApplicationController
  def create
    @submission = current_user.submissions.new(submission_params)
    unless @submission.save
      flash[:alert] = "Submission Failed. #{@submission.errors.full_messages.join(", ")}"
    end

    redirect_to root_path
  end

private
  def submission_params
    params.require(:submission).permit(:url)
  end
end
