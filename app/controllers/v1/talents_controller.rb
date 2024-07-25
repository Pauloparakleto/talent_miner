class V1::TalentsController < V1::ApplicationController
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
      @talent.resume.attach(io: File.open(temp_file_path),
                            filename: original_filename_param,
                            content_type: file_content_type
                           ) if file_param.present?
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

  def file_param
     params.fetch("resume", nil)
  end

  def original_filename_param
    file_param.original_filename
  end

  def temp_file_path
    file_param.tempfile
  end

  def file_content_type
    file_param.content_type
  end

  def set_talent
    @talent = Talent.find(params[:id])
  end

  def talent_params
    params.require(:talent).permit(:name, :email, :mobile_phone, :resume)
  end
end
