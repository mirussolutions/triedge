class Video < ActiveRecord::Base
	validates_presence_of :title, :description, :video_url
	belongs_to :chapter
end
