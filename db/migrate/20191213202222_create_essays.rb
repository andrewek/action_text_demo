class CreateEssays < ActiveRecord::Migration[6.0]
  def change
    create_table :essays do |t|
      t.string :title, null: false, default: ""

      t.timestamps
    end
  end
end
