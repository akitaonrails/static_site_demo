class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug, null: false
      t.string :author
      t.text :summary
      t.text :summary_html
      t.text :body
      t.text :body_html

      t.timestamps null: false
    end
    add_index :pages, [:title], unique: true
    add_index :pages, [:slug], unique: true
  end
end
