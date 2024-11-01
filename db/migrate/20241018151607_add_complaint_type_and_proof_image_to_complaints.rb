class AddComplaintTypeAndProofImageToComplaints < ActiveRecord::Migration[7.2]
  def change
    add_column :complaints, :complaint_type, :string
    add_column :complaints, :proof_image, :string
  end
end
