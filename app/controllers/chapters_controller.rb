class ChaptersController < ApplicationController
  load_and_authorize_resource 
 
  def show
    @chapter = Chapter.find(params[:id])
  end

 
end
