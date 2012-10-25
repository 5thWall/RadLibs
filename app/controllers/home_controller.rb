class HomeController < ApplicationController
  def index
    @toprated = User.toprated
    @toptemplates = Template.toprated
    @topradlibs = Radlib.find_with_reputation(:votes, :all, {:conditions => ["votes > ?", 0], :order => "votes desc", :limit => 5})
    @recenttemplates = Template.find(:all, :order => "id desc", :limit => 5).reverse
    @recentradlibs = Radlib.find(:all, :order => "id desc", :limit => 5).reverse
  end

  def aboutus
  end
end
