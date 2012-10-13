class RenameWordsToRadlibs < ActiveRecord::Migration
def change
        rename_table :words, :radlibs
    end
end
