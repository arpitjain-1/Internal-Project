class NormalUserController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user

  def ensure_normal_user
    # Ensure that only normal users can access this action
    redirect_to root_path, alert: "Access denied." unless current_user.normal_user?
  end

  def dashboard
    @user = current_user
  end

  def profile
    @profile = current_user
  end

  def edit_profile
    @profile = current_user
  end

  def update_profile
    @profile = current_user
    if @profile.update(user_params)
      redirect_to normal_user_profile_path, notice: 'Profile updated successfully.'
    else
      render :edit_profile
    end
  end

  def complaints
    @complaints = current_user.complaints
  end

  private

  # Strong parameters to allow only the necessary fields for update
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
