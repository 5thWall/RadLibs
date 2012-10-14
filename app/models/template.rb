class Template < ActiveRecord::Base
  check_profanity
  attr_accessible  :title, :template, :user_id
  has_many :radlibs
  belongs_to :user
 
  has_reputation :votes, source: :user, aggregated_by: :sum
  
end
