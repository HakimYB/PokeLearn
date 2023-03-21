class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :pokemon_type
      t.text :image_url

      t.timestamps
    end
  end
end
