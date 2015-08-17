class Admin::QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  # GET /admin/quizzes
  # GET /admin/quizzes.json
  def index
    @quizzes = Quiz.all
  end

  # GET /admin/quizzes/1
  # GET /admin/quizzes/1.json
  def show
  end

  # GET /admin/quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /admin/quizzes/1/edit
  def edit
  end

  # POST /admin/quizzes
  # POST /admin/quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to [:admin, @quiz], notice: 'Quiz was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quiz }
      else
        format.html { render action: 'new' }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/quizzes/1
  # PATCH/PUT /admin/quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to [:admin, @quiz], notice: 'Quiz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/quizzes/1
  # DELETE /admin/quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to admin_quizzes_url, notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
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
