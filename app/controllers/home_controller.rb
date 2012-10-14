class HomeController < ApplicationController
  def index
    @toprated = User.find_with_reputation(:votes, :all, {:conditions => ["votes > ?", 0], :order => "votes desc", :limit => 5})
    @toptemplates = Template.find_with_reputation(:votes, :all, {:conditions => ["votes > ?", 0], :order => "votes desc", :limit => 5})
    @topradlibs = Radlib.find_with_reputation(:votes, :all, {:conditions => ["votes > ?", 0], :order => "votes desc", :limit => 5})
    @recenttemplates = Template.where(:created_at => (Time.now - 24.hours)..(Time.now)).limit(5)
    @recentradlibs = Radlib.where(:created_at => (Time.now - 24.hours)..(Time.now)).limit(5)
  end

  def aboutus
  end
end
