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
	 
	 describe "GET #show" do
	 	let(:course) { FactoryGirl.create(:course) }
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
        context "with invalid user logged in" do
        	it "redirects to the sign in page" do
             get :show, id: course.id
             expect(response).to redirect_to new_user_session_path
            end
        end
	 end

    describe "GET #new" do
    	it_behaves_like "sign in mandatory" do
    		let(:action) {get :new}
    	end
    	it_behaves_like "admin mandatory" do
    		let(:action) {get :new}
    	end
    	context "if user is loggedin as an admin" do
    		login_admin
    		it "set the courses to the new course" do
	    		get :new
			    expect(assigns(:course)).to be_instance_of(Course)
			    expect(assigns(:course)).to be_new_record
			end
    	end
    	context "if user loggedin as a regular user" do
    		login_user
	        it "sets the flash error message" do
		      #get :new
		      #expect(flash[:alert]).to be_present
		      expect{get :new}.to raise_error(CanCan::AccessDenied)
		    end
		end
    end

    describe "POST #create" do
    	it_behaves_like "sign in mandatory" do
    		let(:action) {post :create}
    	end
    	it_behaves_like "admin mandatory" do
    		let(:action) {post :create}
    	end
    	context "with valid attributes" do
    		login_admin
    		it "creates the new course" do
    			post :create, course: {title: "workshop on IT Recruitment", description: "In this workshop, one will learn how they can do IT Recruitment"}
    			expect(Course.count).to eq 1
    		end
    		it "redirects to the course index page" do
    			post :create, course: {title: "workshop on IT Recruitment", description: "In this workshop, one will learn how they can do IT Recruitment"}
    			expect(response).to redirect_to admin_courses_path
    		end

        end
    end

end
