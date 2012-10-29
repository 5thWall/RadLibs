class AddIndexToStories < ActiveRecord::Migration
  def change
    add_index "stories", "radlib_id"
    add_index "stories", "user_id"
  end
end
