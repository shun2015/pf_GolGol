class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    #未確認の通知レコードだけ取り出したあと、「未確認→確認済」になるように更新をしています。(indexアクションが呼び出された段階で更新するイメージです)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end