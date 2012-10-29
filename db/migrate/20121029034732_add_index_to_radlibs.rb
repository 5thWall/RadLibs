class AddIndexToRadlibs < ActiveRecord::Migration
  def change
    add_index "radlibs", "user_id"
  end
end
