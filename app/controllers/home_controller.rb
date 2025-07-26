class HomeController < ApplicationController

  def index
    render Components::HomeView.new
  end
end
