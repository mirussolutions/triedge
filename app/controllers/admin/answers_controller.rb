class Admin::AnswersController < ApplicationController
  load_and_authorize_resource
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  # GET /admin/answers
  # GET /admin/answers.json
  def index
    @answers = Answer.all
  end

  # GET /admin/answers/1
  # GET /admin/answers/1.json
  def show
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    @quiz = Quiz.find(@question.quiz_id)
    @chapter = Chapter.find(@quiz.chapter_id)
  end

  # GET /admin/answers/new
  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
    @quiz = Quiz.find(@question.quiz_id)
    @answer.question_id = @question.id
    @chapter = Chapter.find(@quiz.chapter_id)
  end

  # GET /admin/answers/1/edit
  def edit
     @question = Question.find(params[:question_id])
    @quiz = Quiz.find(@question.quiz_id)
    @answer.question_id = @question.id
    @chapter = Chapter.find(@quiz.chapter_id)
  end

  # POST /admin/answers
  # POST /admin/answers.json
  def create
    @answer = Answer.new(answer_params)
    @answer.question_id = params[:question_id]
    @question = Question.find(@answer.question_id)
    @quiz = Quiz.find(@question.quiz_id)
    if @answer.save 
      flash[:success] = "You have added the answer: '#{@answer.title}' successfully."
      redirect_to admin_quiz_question_path(@quiz.id, @question.id)
    else
      flash[:alert] = "The answer is not created. Please check the error messages."
      render :new
    end
  end

  # PATCH/PUT /admin/answers/1
  # PATCH/PUT /admin/answers/1.json
  def update
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    @quiz = Quiz.find(@question.quiz_id)
      if @answer.update(answer_params)
         flash[:success] = "You have updated the answer: '#{@answer.title}' successfully."
         redirect_to admin_question_answer_path(params[:question_id], params[:id])
      else
        flash[:alert] = "The answer was not updated. Please check the error messages."
        render :edit
      end
  end

  # DELETE /admin/answers/1
  # DELETE /admin/answers/1.json
  def destroy
    answer = Answer.find(params[:id])
    if answer.destroy
      flash[:success] = "You successfully deleted the answer '#{answer.title}'."
      redirect_to admin_question_path(params[:question_id])
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:title, :is_correct, :question_id)
    end
end
