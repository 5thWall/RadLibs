class Radlib < ActiveRecord::Base
  attr_accessible :template_id, :user_id, :words
  belongs_to :template
  belongs_to :user

  has_reputation :votes, source: :user, aggregated_by: :sum

  scope :toprated, find_with_reputation(:votes, :all,
    {:conditions => ["votes > ?", 0],
      :order => "votes desc",
      :limit => 5})
end
