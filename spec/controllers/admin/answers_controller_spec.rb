require 'rails_helper'

describe Admin::AnswersController do
  describe "GET #show" do
    before do
      @quiz = FactoryGirl.create(:quiz)
      @question = FactoryGirl.create(:question, quiz_id: @quiz.id)
      @answer = FactoryGirl.create(:answer, question_id: @question.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :show, question_id: @question.id, id: @answer.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :show, question_id: @question.id, id: @answer.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "renders the :show template" do
        get :show, question_id: @question.id, id: @answer.id
        expect(response).to render_template :show
      end
      it "returns an answer" do
        get :show, question_id: @question.id, id: @answer.id
        expect(assigns(:answer)).to be_present
      end
      it "returns a answer for the question" do
        get :show, question_id: @question.id, id: @answer.id
        expect(assigns(:answer).question_id).to eq(@answer.question_id)
      end
    end
    context "with invalid user logged in" do
       it "redirects to the sign in page" do
          get :show, question_id: @question.id, id: @answer.id
          expect(response).to redirect_to new_user_session_path
       end
     end
  end
  describe "GET #new" do
    before do
      @quiz = FactoryGirl.create(:quiz)
      @question = FactoryGirl.create(:question, quiz_id: @quiz.id)
      @answer = FactoryGirl.create(:answer, question_id: @question.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { get :new, question_id: @question.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { get :new, question_id: @question.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "sets the answer to a new answer" do
        get :new, question_id: @question.id
        expect(assigns(:answer)).to be_instance_of(Answer)
        expect(assigns(:answer)).to be_new_record
      end
      it "assigns a question to the answer" do
        get :new, question_id: @question.id
        expect(assigns(:answer).question_id).to eq(@question.id)
      end
    end
    context "If user is loggedin as a regular user" do
      login_user
      it "flashes an error message" do
           expect{ get :new, question_id: @question.id }.to raise_error(CanCan::AccessDenied)
        end
    end
  end

  describe "POST #create" do
    before do
      @quiz = FactoryGirl.create(:quiz)
      @question = FactoryGirl.create(:question, quiz_id: @quiz.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { post :create, question_id: @question.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { post :create, question_id: @question.id }
    end
    context "with valid attributes" do
      login_admin
      it "redirects to the question show page" do
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", is_correct: true }
        expect(response).to redirect_to admin_quiz_question_path(@quiz.id, @question.id)
      end
      it "creates a new answer" do
        post :create, question_id: @question.id, answer: { title: "david heinemeier hanson", is_correct: true }
        expect(Answer.count).to eq(1)
      end
      it "flashes a success message" do
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", is_correct: true }
        expect(flash[:success]).to be_present
      end
      it "sets the property is_correct" do
        post :create, question_id: @question.id, answer: { title: "David Heinemeier Hanson", is_correct: true }
        expect(assigns(:answer).is_correct?).to be true
      end
    end
   context "with invalid attributes" do
      login_admin
      it "renders the :new template" do
        post :create, question_id: @question.id, answer: { title: "", is_correct: true }
        expect(response).to render_template :new
      end
      it "doesn't create a new answer" do
        post :create, question_id: @question.id, answer: { title: "", is_correct: true }
        expect(Answer.count).to eq(0)
      end
      it "sets the @answer variable" do
        post :create, question_id: @question.id, answer: { title: "", is_correct: true} 
        expect(assigns(:answer)).to be_present

      end
      it "flashes an error message" do
        post :create, question_id: @question.id, answer: { title: "", is_correct: true} 
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT #update" do
    before do
      @quiz = FactoryGirl.create(:quiz)
      @question = FactoryGirl.create(:question, quiz_id: @quiz.id)
      @answer = FactoryGirl.create(:answer, question_id: @question.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { put :update, question_id: @question.id, id: @answer.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { put :update, question_id: @question.id, id: @answer.id }
    end
    context "with valid attributes" do
      login_admin
      it "redirects to the answer show page" do
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "title new", is_correct: true }
        expect(response).to redirect_to admin_question_answer_path(@question.id, @answer.id)
      end
      it "updates the answer" do
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "title new", is_correct: true }
        expect(assigns(:answer).title).to eq("title new")
      end
      it "flashes a success message" do
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "title new", is_correct: true }
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid attributes" do
      login_admin
      it "renders the :edit template" do
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "", correct: true }
        expect(response).to render_template :edit
      end
      it "doesn't update the answer" do
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "", correct: true }
        @answer.reload
        expect(@answer.title).not_to eq("")
      end
      it "flashes an error message" do
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "", correct: true }
        expect(flash[:alert]).to be_present
      end
      it "sets the @answer" do
        put :update, question_id: @question.id, id: @answer.id, answer: { title: "", correct: true }
        expect(assigns(:answer)).to be_present
      end
    end
  end
  describe "DELETE #destroy" do
    before do
      @question = FactoryGirl.create(:question)
      @answer = FactoryGirl.create(:answer, question_id: @question.id)
    end
    it_behaves_like "sign in mandatory" do
      let(:action) { delete :destroy, question_id: @question.id, id: @answer.id }
    end
    it_behaves_like "admin mandatory" do
      let(:action) { delete :destroy, question_id: @question.id, id: @answer.id }
    end
    context "If user is loggedin as an admin" do
      login_admin
      it "redirects to the question show page" do
        delete :destroy, question_id: @question.id, id: @answer.id
        expect(response).to redirect_to admin_question_path(@question.id)
      end
      it "deletes the answer" do
        delete :destroy, question_id: @question.id, id: @answer.id
        expect(@question.answers.count).to eq(0)
      end
      it "flashes a success message" do
        delete :destroy, question_id: @question.id, id: @answer.id
        expect(flash[:success]).to be_present
      end
    end
  end
end
