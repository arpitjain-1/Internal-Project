class Users::SessionsController < Devise::SessionsController
  # New authority login form
  def new_authority
    @user = User.new
    render :new_authority
  end

  # Process authority login
  def create_authority
    login_user('authority')
  end

  # New normal user login form
  def new_normal_user
    @user = User.new
    render :new_normal_user
  end

  # Process normal user login
  def create_normal_user
    login_user('normal_user')
  end

  private

  # Common logic for both authority and normal user login
  def login_user(role)
    # Check for the presence of parameters
    email = params.dig(:user, :email)
    password = params.dig(:user, :password)

    if email.blank? || password.blank?
      flash[:alert] = "Email and password can't be blank"
      return render role == 'authority' ? :new_authority : :new_normal_user
    end

    @user = User.find_by(email: email)

    if @user && @user.role == role && @user.valid_password?(password)
      sign_in @user
      redirect_to role == 'authority' ? authority_dashboard_path : normal_user_dashboard_path
    else
      flash[:alert] = "Invalid email or password for #{role.titleize}"
      render role == 'authority' ? :new_authority : :new_normal_user
    end
  end
end
