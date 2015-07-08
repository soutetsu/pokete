class HomeController < ApplicationController
  def index
    redirect_to recent_bokes_path
  end
end
