class V1::RecruitersController < ApplicationController
  before_action :set_recruiter, only: [:show, :update, :destroy]

  def index
    @recruiters = Recruiter.all

    render json: @recruiters
  end

  def show
    render json: @recruiter
  end

  def create
    @recruiter = Recruiter.new(recruiter_params)

    if @recruiter.save
      render json: @recruiter, status: :created
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recruiter.update(recruiter_params)
      render json: @recruiter
    else
      render json: @recruiter.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recruiter.destroy
  end

  private

    def set_recruiter
      @recruiter = Recruiter.find(params[:id])
    end

    def recruiter_params
      params.require(:recruiter).permit(:name, :email, :password)
    end
 end
