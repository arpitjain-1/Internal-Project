class ComplaintsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user, only: [:new, :create]
  before_action :ensure_authority, only: [:index, :resolve, :reject]

  def new
    @complaint = Complaint.new
  end

  def create
    @complaint = current_user.complaints.build(complaint_params)
    @complaint.status = 'pending' 
    if @complaint.save
      redirect_to normal_user_dashboard_path, notice: 'Complaint registered successfully.'
    else
      render :new
    end
  end

  def index
    @complaints = Complaint.all
  end

  def resolve
    @complaint = Complaint.find(params[:id])
    if @complaint.status == 'pending'  # Ensure only pending complaints can be resolved
      @complaint.update(status: 'resolved')
      redirect_to complaints_path, notice: 'Complaint resolved successfully.'
    else
      redirect_to complaints_path, alert: 'Complaint already resolved or rejected.'
    end
  end

  def reject
    @complaint = Complaint.find(params[:id])
    if @complaint.status == 'pending'  # Ensure only pending complaints can be rejected
      @complaint.update(status: 'rejected')
      redirect_to complaints_path, notice: 'Complaint rejected.'
    else
      redirect_to complaints_path, alert: 'Complaint already resolved or rejected.'
    end
  end

  private

  def ensure_normal_user
    redirect_to root_path, alert: 'Access denied!' unless current_user.normal_user?
  end

  def ensure_authority
    redirect_to root_path, alert: 'Access denied!' unless current_user.authority?
  end

  def complaint_params
    params.require(:complaint).permit(:description, :proof_image, :complaint_type_id)
  end

end
