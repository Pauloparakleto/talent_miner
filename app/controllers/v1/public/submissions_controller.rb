class V1::Public::SubmissionsController < ApplicationController
  INITIAL_PAGE = 1
   
  before_action :set_submission, only: [:show]

  def index
    @submissions = Public::Submission.order(:created_at).page params.fetch(:page, INITIAL_PAGE)
    render :index, status: :ok
  end

  def show
    render :show
  end

  def create
    byebug
  end

  private

  def set_submission
    @submission = Public::Submission.find(params[:id])
  end
end
