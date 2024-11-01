class CreateComplaintTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :complaint_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
