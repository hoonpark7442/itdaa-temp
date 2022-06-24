class ClassesController < ApplicationController
	def create
		if @itdaa_class.save
			@metor.followers.each do |user|
				return unless user.allow_notification?

				NotificationSubscription.create(
	        user: user, notifiable_id: @itdaa_class.id, notifiable_type: "ItdaaClass", type: "new_creation",
	      )
			end

			Notification.send_new_creation_notifications(@itdaa_class)
		end
	end
end

# NotificationSubscription, Notification 는 여러 타입의 공지가 있을 것으로 보여 polymorphic으로 생성해야 될 것 같습니다.