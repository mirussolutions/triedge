class Admin::QuizzesController < ApplicationController
  load_and_authorize_resource
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  # GET /admin/quizzes
  # GET /admin/quizzes.json
  def index
    @quizzes = Quiz.all
  end

  # GET /admin/quizzes/1
  # GET /admin/quizzes/1.json
  def show
    @quiz = Quiz.find(params[:id])
    @chapter = Chapter.find(@quiz.chapter_id)
  end

  # GET /admin/quizzes/new
  def new
    @chapter = Chapter.find(params[:chapter_id])
    if @chapter.quiz.present?
      flash[:alert] = "Chapter #{@chapter.title} already has a quiz"
      redirect_to admin_chapter_path(@chapter.id)
    else
      @quiz = Quiz.new
      @quiz.chapter_id = @chapter.id
    end
  end

  # GET /admin/quizzes/1/edit
  def edit
    @quiz = Quiz.find(params[:id])
    @chapter = Chapter.find(params[:chapter_id])
  end

  # POST /admin/quizzes
  # POST /admin/quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)

    @quiz.chapter_id = params[:chapter_id]
    @chapter = Chapter.find(@quiz.chapter_id)
    if @quiz.save 
      flash[:success] = "You have created a new quiz, #{ @quiz.title } successfully."
      redirect_to admin_chapter_path(params[:chapter_id])
    else
      flash[:alert] = "The quiz was not created. Please check the error messages."
      render :new
    end
  end

  # PATCH/PUT /admin/quizzes/1
  # PATCH/PUT /admin/quizzes/1.json
  def update
    @chapter = Chapter.find(params[:chapter_id])
      if @quiz.update(quiz_params)
        flash[:success] = "You have updated quiz: '#{@quiz.title}' successfully."
        redirect_to admin_chapter_quiz_path(params[:chapter_id], params[:id])
      else
        flash[:alert] = "The quiz was not updated. Please check the error messages."
        render :edit
      end
  end

  # DELETE /admin/quizzes/1
  # DELETE /admin/quizzes/1.json
  def destroy
    if @quiz.destroy
      flash[:success] = "You have deleted the quiz: '#{@quiz.title}' successfully."
      redirect_to admin_chapter_path(params[:chapter_id])  
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:title, :chapter_id)
    end
end
