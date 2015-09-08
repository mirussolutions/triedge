shared_examples "sign in mandatory" do
  it "redirects to the sign in page" do
    session[:user] = nil
    action
    expect(response).to redirect_to(new_user_session_path)
  end
end

shared_examples "admin mandatory" do
  it "redirects to the sign in page" do
    session[:user_id] = FactoryGirl.create(:user).id 
    action
    expect(response).to redirect_to(new_user_session_path)
  end
end

shared_examples "admin" do
  it "valid admin" do
    @admin = FactoryGirl.create(:admin)
    sign_in @admin
    action
    expect(response.status).to eq(200)
  end
end
