class RenameRadlibsToStories < ActiveRecord::Migration
  def change
    rename_table :radlibs, :stories
  end
end
