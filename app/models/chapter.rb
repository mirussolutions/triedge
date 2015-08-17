class Chapter < ActiveRecord::Base
	validates_presence_of :title, :description
	belongs_to :course
	has_many :videos
	has_one :quiz
end
