# send notifications about the new comment

module Notifications
  module NewCreation
    class Send
      def initialize(itdaa_class)
        @itdaa_class = itdaa_class
      end

      def self.call(...)
        new(...).call
      end

      def call
        user_ids = subscribed_user_ids("new_creation")

        payload = {
          targets: user_ids,
          title: "새로운 클래스가 생성되었습니다",
          body: "팔로우 하신 #{@itdaa_class.mentor} 님의 클래스가 새로 개설되었습니다"
        }

        job_id = Notifications::MessageSender.perform_aync(payload)

        # 말씀해주신 pub/sub 시스템 혹은 제가 아는 선에서는 sidekiq-status gem을 통해 
        data = Sidekiq::Status::get_all(job_id)
        status = Sidekiq::Status::message(job_id)

        # 성능 고려해서 리팩토링 필요할 것으로 보입니다.
        # 실패 했을 경우 처리가 좀 부족해 보입니다. 좀 더 고민해보겠습니다.
        # 실패 했을 경우에 각각의 Notification status에 false 데이터를 입력해야 될 거 같습니다.
        if status == "success" 
          user_ids.each do |user|
            Notification.create(
              user_id: user_id,
              notifiable_id: @itdaa_class.id,
              notifiable_type: @itdaa_class.class.name,
              action: "new_creation",
              notified_at: Date.time.now,
              status: true
            )
          end
        end
      end

      private

      def subscribed_user_ids(type)
        NotificationSubscription
          .where(notifiable_id: @itdaa_class.id, notifiable_type: "ItdaaClass", type: type)
          .pluck(:user_id)
      end
    end
  end
end
