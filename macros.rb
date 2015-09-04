def sign_in(a_user=nil)
    user = a_user || FactoryGirl(:user) 
    visit sign_in_path
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
end

def set_current_user(user = nil)
  session[:user_id] = (user || FactoryGirl(:user)).id
end

def set_current_admin(admin = nil)
  session[:user_id] = (admin || FactoryGirl(:user)).id
end
