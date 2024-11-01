class CreateComplaints < ActiveRecord::Migration[7.2]
  def change
    create_table :complaints do |t|
      t.text :description
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
