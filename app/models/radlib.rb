class Radlib < ActiveRecord::Base
  attr_accessible :template_id, :user_id, :radlib
  belongs_to :template
end
