class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.string :title, limit: 30, null: false
      t.text :description, null: false
      t.integer :wages, null: false
      t.datetime :start, null: false
      t.datetime :end, null: false

      t.timestamps
    end
  end
end
