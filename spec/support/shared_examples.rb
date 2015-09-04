shared_examples "sign in mandatory" do
  it "redirects to the sign in page" do
    session[:user_id] = nil
    expect(response).to redirect_to new_user_session_path
  end
end

shared_examples "admin mandatory" do
  it "redirects to the home page" do
    session[:user_id] = FactoryGirl.create(:user).id 
    
    expect(response).to redirect_to root_path
  end
end
