class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.integer :notifitable_id
      t.string :notifitable_type
      t.datetime :notified_at
      t.boolean :status

      t.timestamps
    end
  end
end
