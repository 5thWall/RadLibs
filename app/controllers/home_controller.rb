class HomeController < ApplicationController
  def index
    @toprated = User.toprated
    @toptemplates = Template.toprated
    @topradlibs = Radlib.toprated
    @recenttemplates = Template.recent
    @recentradlibs = Radlib.find(:all, :order => "id desc", :limit => 5).reverse
  end

  def aboutus
  end
end
