class SubmissionsController < ApplicationController
  def create
    @submission = current_user.submissions.new(submission_params)
    if @submission.save
      flash[:notice] = "Submitted Successfully"
    else
      flash[:alert] = "Submission Failed. #{@submission.errors.full_messages.join(", ")}"
    end

    redirect_to root_path
  end

private
  def submission_params
    params.require(:submission).permit(:url)
  end
end
