class AddColumn < ActiveRecord::Migration[7.2]
  def change
    add_column :complaints, :title, :string
  end
end
