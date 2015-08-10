class Admin::ChaptersController < AdminController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]

  # GET /admin/chapters
  # GET /admin/chapters.json
  def index
    @course = Course.find(params[:course_id])
    @chapters = @course.chapters
  end

  # GET /admin/chapters/1
  # GET /admin/chapters/1.json
  def show
    @chapter = Chapter.find(params[:id])
  end

  # GET /admin/chapters/new
  def new
    @chapter = Chapter.new
    @course = Course.find(params[:course_id])
  end

  # GET /admin/chapters/1/edit
  def edit
    @chapter = Chapter.find(params[:id])
    @course = Course.find(@chapter.course_id)
  end

  # POST /admin/chapters
  # POST /admin/chapters.json
  def create
    @chapter.course_id = params[:course_id] 
    @course = Course.find(@chapter.course_id)
    @chapter = @course.chapter.create(chapter_params)

    respond_to do |format|
      if @chapter.save
      flash[:success] = "You created a new chapter, '#{ @chapter.title }' for course #{ @chapter.course_id }"
      redirect_to admin_course_path(@chapter.course_id)
    else
      flash[:alert] = "You could not create a new chapter. Please check the error messages."
      render :new
    end
    end
  end

  # PATCH/PUT /admin/chapters/1
  # PATCH/PUT /admin/chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to [:admin, @chapter], notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/chapters/1
  # DELETE /admin/chapters/1.json
  def destroy
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to admin_course_path, notice: 'Chapter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :description, :course_id)
    end
end
