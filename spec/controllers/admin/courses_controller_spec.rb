require 'rails_helper'

describe Admin::CoursesController do

 
	 #context 'not logged in' do
	  #      it_behaves_like 'sign in mandatory'
	# end

	 #context 'not logged in as admin' do
	 #       it_behaves_like 'admin mandatory'
	 #end

	 #context 'logged in as admin' do
	       # it_behaves_like 'admin'
	 #end
     #before(:each) do
	 #		@newcourse = FactoryGirl.create(:course)
	 #end
	 #binding.pry it gives the nil object
	 let(:course) { FactoryGirl.create(:course) }
	 describe "GET #show" do
	 	    it_behaves_like "sign in mandatory" do
	    	let(:action) { get :show, id: course.id }
	    end
	    it_behaves_like "admin mandatory" do
            let(:action) { get :new }
        end
        context "with admin logged in" do
        	login_admin
        	it "sets the course" do
              get :show, :id => course.id
              expect(assigns(:course)).to be_present
        	end
        end
	 end
  
end
