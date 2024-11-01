class AuthoritiesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_authority

  def ensure_authority
    Rails.logger.debug "Current User Role: #{current_user.role}"
    # Redirect to root if the user is not an authority
    redirect_to root_path, alert: "Access denied." unless current_user.authority?
  end

  def dashboard
    @user = current_user
  end

  def pending_complaints
    @pending_complaints = Complaint.where(status: 'pending')
  end

  def profile
    @authority = current_user
  end

  def edit_profile
    @authority = current_user  # Show form for editing
  end

  def update_profile
    @authority = current_user
    if @authority.update(authority_params)
      redirect_to authority_profile_path, notice: 'Profile updated successfully.'
    else
      render :edit_profile
    end
  end

  private

  # Strong parameters for updating profile
  def authority_params
    params.require(:user).permit(:name, :email)  # Add more fields as needed
  end
end
