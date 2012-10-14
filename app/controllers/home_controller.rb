class HomeController < ApplicationController
  def index
    @toprated = User.find_with_reputation(:votes, :all, {:conditions => ["votes > ?", 0], :order => "votes desc", :limit => 5})
    @toptemplates = Template.find_with_reputation(:votes, :all, {:conditions => ["votes > ?", 0], :order => "votes desc", :limit => 5})
  end
end
