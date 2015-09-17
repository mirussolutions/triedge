class Evaluation
  def initialize(quiz, user)
    @quiz = quiz
    @user = user
  end

  def pass?
    complete and return true if wrong_answers <= 2
  end

  private


  def wrong_answers
    wrong_answers = 0
    @quiz.questions.each do |question|
      answer = @user.answers.where("question_id = ?", question.id).first
      wrong_answers += 1 unless answer.is_correct
    end

    return wrong_answers
  end

  def complete
   @user.quizzes << @quiz 
  end
end
