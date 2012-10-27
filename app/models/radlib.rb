class Radlib < ActiveRecord::Base
  attr_accessible  :title, :template, :user_id
  has_many :stories
  belongs_to :user

  delegate :name, to: :user, prefix: true

  has_reputation :votes, source: :user, aggregated_by: :sum
  resourcify

  default_scope order: "created_at desc"
  scope :toprated, find_with_reputation(:votes, :all,
    {:conditions => ["votes > ?", 0],
      :order => "votes desc",
      :limit => 5})
  scope :recent, limit: 5
end
