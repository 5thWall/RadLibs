class HomeController < ApplicationController
  def index
    @toprated = User.toprated
    @toptemplates = Template.toprated
    @topradlibs = Radlib.toprated
    @recenttemplates = Template.recent
    @recentradlibs = Radlib.recent
  end

  def aboutus
  end
end
