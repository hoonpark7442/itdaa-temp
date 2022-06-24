class Notification < ApplicationRecord
  belongs_to :user

  def send_new_creation_notifications(itdaa_class)
    Notifications::NewCreation::Send.call(comment)
  end
end
