class ChangeComplaintTypeIdToNotNullInComplaints < ActiveRecord::Migration[7.2]
  def change
    change_column_null :complaints, :complaint_type_id, false
  end
end
