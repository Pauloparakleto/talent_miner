class V1::Public::SubmissionsController < V1::ApplicationController
  INITIAL_PAGE = 1
   
  before_action :set_submission, only: [:show, :destroy]

  def index
    @submissions = Public::Submission.order(:created_at).page params.fetch(:page, INITIAL_PAGE)
    render :index, status: :ok
  end

  def show
    render :show
  end

  def create
    @submission = Public::Submission.new(submission_params)
    if @submission.valid?
      Public::SubmissionCreatorJob.perform_later(submission_params)
      render :show, status: :created, location: "v1/public/submissions/#{@submission.id}"
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @submission.destroy
  end

  private

  def set_submission
    @submission = Public::Submission.find(params[:id])
  end

  def submission_params
    params.require(:submission).permit(:job_id, :talent_id)
  end
end
