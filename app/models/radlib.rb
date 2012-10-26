class Radlib < ActiveRecord::Base
  attr_accessible :template_id, :user_id, :words
  belongs_to :template
  belongs_to :user

  delegate :title, to: :template, prefix: true
  delegate :name, to: :user, prefix: true

  has_reputation :votes, source: :user, aggregated_by: :sum

  default_scope order: "created_at desc"
  scope :toprated, find_with_reputation(:votes, :all,
    {:conditions => ["votes > ?", 0],
     :order => "votes desc",
     :limit => 5})
  scope :recent, limit: 5
end
