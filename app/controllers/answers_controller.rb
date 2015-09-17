class AnswersController < ApplicationController
  load_and_authorize_resource
  

  def update

    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
    @quiz = Quiz.find(@question.quiz.id)
    @chapter = Chapter.find(@quiz.chapter_id)
    @course = Course.find(@chapter.course_id)
    current_user.answers << @answer
  end

end
