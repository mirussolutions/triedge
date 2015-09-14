class Admin::ChaptersController < ApplicationController
  load_and_authorize_resource 
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]
  layout 'admin'
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
    
 @chapter = Chapter.create(chapter_params)
    @chapter.course_id = params[:course_id] 
    @course = Course.find(@chapter.course_id)
      if @chapter.save
      flash[:success] = "You created a new chapter, '#{ @chapter.title }' for course #{ @chapter.course_id }"
      redirect_to admin_course_path(@chapter.course_id)
    else
      flash[:alert] = "You could not create a new chapter. Please check the error messages."
      render :new
    end
   
  end

  # PATCH/PUT /admin/chapters/1
  # PATCH/PUT /admin/chapters/1.json
  def update
     if @chapter.update(chapter_params)
        flash[:success] = "You have updated chapter '#{ @chapter.title }' successfully."
        redirect_to admin_course_chapter_path(@chapter.course_id, @chapter.id)
      else
        flash[:alert] = "The chapter was not updated. Please check the error messages."
        render :edit
      end
  end

  # DELETE /admin/chapters/1
  # DELETE /admin/chapters/1.json
  def destroy
    @chapter.destroy
    if @chapter.destroy
      flash[:success] = "You have deleted chapter '#{@chapter.title}' successfully."
      redirect_to admin_course_path(@chapter.course_id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :description, :course_id, :tagline, :badge_image)
    end
end
