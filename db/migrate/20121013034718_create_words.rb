class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.integer :template_id
      t.integer :user_id
      t.text :word

      t.timestamps
    end
  end
end
