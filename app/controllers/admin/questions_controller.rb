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
  end

  # GET /admin/questions/new
  def new
    @question = Question.new
  end

  # GET /admin/questions/1/edit
  def edit
  end

  # POST /admin/questions
  # POST /admin/questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to [:admin, @question], notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/questions/1
  # PATCH/PUT /admin/questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to [:admin, @question], notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/questions/1
  # DELETE /admin/questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to admin_questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
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
