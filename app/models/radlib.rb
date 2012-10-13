class Radlib < ActiveRecord::Base
  attr_accessible :template_id, :user_id, :words
  belongs_to :template
end
