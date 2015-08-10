class Course < ActiveRecord::Base
	validates_presence_of :title, :description
	has_many :chapters
end
