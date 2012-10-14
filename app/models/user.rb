class User < ActiveRecord::Base
  rolify
  attr_accessible :provider, :uid, :name, :email
  
  has_many :templates
  has_many :radlibs
  
  has_many :evaluations, class_name: "RSEvaluation", as: :source
  
  has_reputation :votes, source: {reputation: :votes, of: :templates}, aggregated_by: :sum
  
  def voted_for?(template)
    evaluations.where(target_type: template.class, target_id: template.id).present?
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
