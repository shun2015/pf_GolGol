module NotificationsHelper
  def notification_form(notification)
    #通知の一部をリンクにして、下のcase文の中で使用
    visitor = link_to notification.visitor.name, notification.visitor, class: "visitor_name"
    your_post = link_to 'あなたの投稿', notification.post, class: "your_post"
    case notification.action
      when "favorite" then
        "#{visitor}さんが#{your_post}にいいね！しました"
      when "comment" then
        "#{visitor}さんが#{your_post}にコメント！しました"
    end
  end
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
