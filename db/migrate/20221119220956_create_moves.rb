class CreateMoves < ActiveRecord::Migration[7.0]
  def change
    create_table :moves do |t|
      t.string :name
      t.string :tipo
      t.integer :accuracy
      t.integer :priority
      t.integer :power
      t.integer :pp

      t.timestamps
    end
  end
end
