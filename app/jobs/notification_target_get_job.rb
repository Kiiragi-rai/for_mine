class NotificationTargetGetJob < ApplicationJob
  queue_as :default
# target取得
# management保存
# waituntilでjobに渡す
  def perform(*args)
    # Do something later
  end
end
