class StaticPagesController < ApplicationController

  # Controller home_page 
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  #  Controller help_page
  def help
  end
end
