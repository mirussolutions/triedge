class Admin::AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /admin/answers
  # GET /admin/answers.json
  def index
    @answers = Answer.all
  end

  # GET /admin/answers/1
  # GET /admin/answers/1.json
  def show
  end

  # GET /admin/answers/new
  def new
    @answer = Answer.new
  end

  # GET /admin/answers/1/edit
  def edit
  end

  # POST /admin/answers
  # POST /admin/answers.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to [:admin, @answer], notice: 'Answer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @answer }
      else
        format.html { render action: 'new' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/answers/1
  # PATCH/PUT /admin/answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to [:admin, @answer], notice: 'Answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/answers/1
  # DELETE /admin/answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to admin_answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
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
