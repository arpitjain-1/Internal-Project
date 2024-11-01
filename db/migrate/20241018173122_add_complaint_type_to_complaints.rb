class AddComplaintTypeToComplaints < ActiveRecord::Migration[7.2]
  def change
    add_reference :complaints, :complaint_type, null: true, foreign_key: true
  end
end
