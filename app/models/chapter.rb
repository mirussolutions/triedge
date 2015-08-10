class Chapter < ActiveRecord::Base
	validates_presence_of :title, :description
	belongs_to :course
end
