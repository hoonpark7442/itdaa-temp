class CreateNotificationSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :notification_subscriptions do |t|
      t.integer :notifiable_id
      t.string :notifiable_type
      t.references :user, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
