class Question < ActiveRecord::Base
	validates_presence_of :title
	belongs_to :quiz
	has_many :answers
end
