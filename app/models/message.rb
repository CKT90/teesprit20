class Message < ActiveRecord::Base
belongs_to :user
validates :sender_email, :content, :subject, presence: true

end
