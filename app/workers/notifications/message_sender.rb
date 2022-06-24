module Notifications
  class MessageSender
    include Sidekiq::Worker
    sidekiq_options queue: :default, retry: 5

    def perform(payload)
      # 메세지 전송
    end
  end
end
