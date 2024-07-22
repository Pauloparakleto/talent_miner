class V1::TalentsController < ApplicationController
  INITIAL_PAGE = 1

  before_action :set_talent, only: [:show, :update, :destroy]

  def index
    @talents = Talent.order(:created_at).page params.fetch(:page, INITIAL_PAGE)

    render :index
  end

  def show
    render :show
  end

  def create
    @talent = Talent.new(talent_params)

    if @talent.save
      render :show, status: :created
    else
      render json: @talent.errors, status: :unprocessable_entity
    end
  end

  def update
    if @talent.update(talent_params)
      render :show
    else
      render json: @talent.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @talent.destroy
  end

  private

    def set_talent
      @talent = Talent.find(params[:id])
    end

    def talent_params
      params.require(:talent).permit(:name, :email, :mobile_phone, :resume)
    end
end
