require 'rails_helper'

describe Admin::CoursesController do

 
	 context 'not logged in' do
	        it_behaves_like 'sign in mandatory'
	 end

	 context 'not logged in as admin' do
	        it_behaves_like 'admin mandatory'
	 end

	 context 'logged in as admin' do
	        it_behaves_like 'admin'
	 end

  
end
