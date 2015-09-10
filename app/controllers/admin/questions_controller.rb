class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /admin/questions
  # GET /admin/questions.json
  def index
    @questions = Question.all
  end

  # GET /admin/questions/1
  # GET /admin/questions/1.json
  def show
    @question = Question.find(params[:id]) 
    @quiz = Quiz.find(@question.quiz_id)
    @chapter = Chapter.find(@quiz.chapter_id)
  end

  # GET /admin/questions/new
  def new
    @question = Question.new
    @quiz = Quiz.find(params[:quiz_id])
    @question.quiz_id = @quiz.id
    @chapter = Chapter.find(@quiz.chapter_id)
  end

  # GET /admin/questions/1/edit
  def edit
    @quiz = Quiz.find(params[:quiz_id])
    @chapter = Chapter.find(@quiz.chapter_id)
  end

  # POST /admin/questions
  # POST /admin/questions.json
  def create
    @question = Question.new(question_params)
    @question.quiz_id = params[:quiz_id]
    @quiz = Quiz.find(@question.quiz_id)
    if @question.save
      flash[:success] = "You have created the question: '#{@question.title}' successfully."
      redirect_to admin_quiz_path(params[:quiz_id])
    else
      flash[:alert] = "The question was not created. Please check the error messages."
      render :new
    end
  end

  # PATCH/PUT /admin/questions/1
  # PATCH/PUT /admin/questions/1.json
  def update
    @question = Question.find(params[:id])
    @quiz = Quiz.find(@question.quiz_id)
   
      if @question.update(question_params)
        flash[:success] = "You updated the question '#{@question.title}' successfully."
        redirect_to admin_quiz_question_path(params[:quiz_id], params[:id])
      else
        flash[:alert] = "The question was not updated. Please check the error messages."
        render :edit
      end
    
  end

  # DELETE /admin/questions/1
  # DELETE /admin/questions/1.json
  def destroy
    question = Question.find(params[:id])
    if question.destroy
      flash[:success] = "You have deleted question '#{question.title}' successfully."
      redirect_to admin_quiz_path(params[:quiz_id])
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :quiz_id)
    end
end
