class Chapter < ActiveRecord::Base
	validates_presence_of :title, :description
	belongs_to :course
	has_many :videos
	has_one :quiz
	mount_uploader :badge_image, BadgeImageUploader
end
