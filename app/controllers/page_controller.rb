class PageController < ApplicationController
	skip_before_filter :authenticate_user!
	def home
	end

	def subscription
	end
end
