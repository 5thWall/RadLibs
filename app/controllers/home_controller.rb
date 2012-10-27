class HomeController < ApplicationController
  def index
    @toprated = User.toprated
    @topradlibs = Radlib.toprated
    @topstories = Story.toprated
    @recentradlibs = Radlib.recent
    @recentstories = Story.recent
  end

  def aboutus
  end
end
