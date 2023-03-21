class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @user = User.new
  end

  def dashboard
    @user = current_user
    # @user_pokemons = @user.
  end

  def index
  end
end
