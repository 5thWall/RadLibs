class RenameTemplatesToRadlibs < ActiveRecord::Migration
  def change
    rename_table :templates, :radlibs
    rename_column :stories, :template_id, :radlib_id
  end
end
