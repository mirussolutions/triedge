class Admin::CoursesController < ApplicationController
  load_and_authorize_resource :class => Course, :instance_name => "course"
  # GET /courses
  # GET /courses.json
  layout 'admin'
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "You have created the course '#{ @course.title }' successfully."
      redirect_to admin_courses_path
    else
      flash[:alert] = "You are not allowed to add this course. Please check the errors."
      render :new
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
      if @course.update(course_params)
        flash[:success] = "You have updated the course '#{ @course.title }' successfully"
        redirect_to admin_courses_path
    else
        flash[:alert] = "You are not update this record. Please check the errors."
        render :edit 
      end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    flash[:success] = "You have successfully deleted the course '#{ @course.title }'."
    redirect_to admin_courses_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :description, :image)
    end
end
