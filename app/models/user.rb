class User < ApplicationRecord
  has_many :user_pokemons
  has_many :quizzes
  has_many :pokemons, through: :user_pokemons
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
