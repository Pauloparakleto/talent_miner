class V1::Recruiter::JobsController < ApplicationController
  before_action :set_recruiter_job, only: %i[ show update destroy ]

  def index
    @recruiter_jobs = Recruiter::Job.all
    render json: @recruiter_jobs, status: :ok, location: "v1/recruiter/jobs/"
  end

  def show
    render json: @recruiter_job, status: :ok, location: "v1/recruiter/jobs/#{@recruiter_job.id}"
  end

  def create
    @recruiter_job = Recruiter::Job.new(recruiter_job_params)
    if @recruiter_job.save
      render json: @recuiter_job, status: :created, location: "v1/recruiter/jobs/#{@recruiter_job.id}"
    else
      render json: @recruiter_job.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recruiter_job.update(recruiter_job_params)
      render json: @recruiter_job, status: :ok, location: "v1/recruiter/jobs/#{@recruiter_job.id}"
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
