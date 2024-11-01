class RemoveTitleFromComplaints < ActiveRecord::Migration[7.2]
  def change
    remove_column :complaints, :title, :string
  end
end
