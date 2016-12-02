module ApplicationHelper
  def disp_active_user
    user = User.find session[:user_id]
    user.email
  end
end
