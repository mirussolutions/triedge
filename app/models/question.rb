class Question < ActiveRecord::Base
	validates_presence_of :title
	belongs_to :quiz
	has_many :answers

	  def self.next(previous_question)
	    Question.order(:id)
	    where("id > ?", previous_question).first
	  end

	  def self.is_last?(question_id)
	    question = Question.find(question_id)
	    last_question = Question.last
	    if question.id == last_question.id 
	      return true
	    else
	      return false
	    end
	  end
end
