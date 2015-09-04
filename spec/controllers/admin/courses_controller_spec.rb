require 'rails_helper'

describe Admin::CoursesController do

 
	 context 'not logged in' do
	        it_behaves_like 'sign in mandatory'
	 end

  
end
