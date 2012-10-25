class HomeController < ApplicationController
  def index
    @toprated = User.toprated
    @toptemplates = Template.toprated
    @topradlibs = Radlib.toprated
    @recenttemplates = Template.find(:all, :order => "id desc", :limit => 5).reverse
    @recentradlibs = Radlib.find(:all, :order => "id desc", :limit => 5).reverse
  end

  def aboutus
  end
end
