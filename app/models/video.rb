class Video < ActiveRecord::Base
	validates_presence_of :title, :description, :video_url
	belongs_to :chapter

	has_many :watches
    has_many :users, through: :watches
end
