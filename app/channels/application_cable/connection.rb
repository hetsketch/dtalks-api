module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = verify_user
    end

    def disconnect
      ActionCable.server.broadcast(
        "notifications",
        type: 'alert', data: "#{current_user} disconnected"
      )
    end

    private

    def verify_user
      puts 123
      # cookies[:username].presence || reject_unauthorized_connection
    end
  end
end
