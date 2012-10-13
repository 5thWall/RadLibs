class RenameWordToWordsInRadlibs < ActiveRecord::Migration
  def change
    rename_column :radlibs, :word, :words
  end
end
