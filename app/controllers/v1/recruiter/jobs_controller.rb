class V1::Recruiter::JobsController < V1::ApplicationController
  INITIAL_PAGE = 1
  STATUS_ACTIVE = 1

  before_action :set_recruiter_job, only: %i[ show update destroy ]

  def index
    @recruiter_jobs = Recruiter::Job.order(:created_at)
      .where(status: Recruiter::JobEnum::ACTIVE)
      .page params.fetch(:page, INITIAL_PAGE)

    render :index, location: "v1/recruiter/jobs/"
  end

  def show
    render json: @recruiter_job, status: :ok, location: "v1/recruiter/jobs/#{@recruiter_job.id}"
  end

  def create
    @recruiter_job = Recruiter::Job.new(recruiter_job_params)
    if @recruiter_job.valid?
      Recruiter::JobCreatorJob.perform_later(recruiter_job_params)
      render :show, status: :created, location: "v1/recruiter/jobs/#{@recruiter_job.id}"
    else
      render json: @recruiter_job.errors, status: :unprocessable_entity
    end
  end

  def update
    @recruiter_job.assign_attributes(recruiter_job_params)
    if @recruiter_job.valid?
      Recruiter::JobUpdaterJob.perform_later(@recruiter_job.id, recruiter_job_params)
      render :show, status: :ok, location: "v1/recruiter/jobs/#{@recruiter_job.id}"
    else
      render json: @recruiter_job.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recruiter_job.destroy
  end

  private
    
    def set_recruiter_job
      @recruiter_job = Recruiter::Job.find(params[:id])
    end

    def recruiter_job_params
      params.require(:recruiter_job).permit(:title, :description, :start_date, :end_date, :status,  :recruiter_id, skills: [])
    end
end
