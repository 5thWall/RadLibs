class Radlib < ActiveRecord::Base
  attr_accessible :template_id, :user_id, :words
  belongs_to :template
  belongs_to :user
  
    has_reputation :votes, source: :user, aggregated_by: :sum
end
