class CreateItdaaClasses < ActiveRecord::Migration[6.0]
  def change
    create_table :itdaa_classes do |t|
      t.string :title
      t.references :mentor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
