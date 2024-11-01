class UpdateStatus < ActiveRecord::Migration[7.2]
  def change
    change_column_default :complaints, :status, 'pending'
  end
end
