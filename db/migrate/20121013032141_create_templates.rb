class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :title
      t.text :template, :limit => 360
      t.integer :user_id

      t.timestamps
    end
  end
end
