class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = User.new
  end

  def dashboard
    @pokemons = Pokemon.all
    @user = current_user
  end

  def map
  end
end
