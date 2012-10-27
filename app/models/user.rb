class User < ActiveRecord::Base
  rolify
  attr_accessible :provider, :uid, :name, :email

  has_many :radlibs
  has_many :stories

  has_many :evaluations, class_name: "RSEvaluation", as: :source

  has_reputation :votes, source: [{reputation: :votes, of: :radlibs}, {reputation: :votes, of: :stories}], aggregated_by: :sum

  scope :toprated, find_with_reputation(:votes, :all, {:conditions => ["votes > ?", 0], :order => "votes desc", :limit => 5})

  def voted_for_radlib?(radlib)
    evaluations.where(target_type: "Radlib", target_id: radlib.id).present?
  end
def voted_for_story?(story)
  evaluations.where(target_type: "Story", target_id: story.id).present?
end
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

end
