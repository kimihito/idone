class CleanupUnusedTagJob < ApplicationJob
  queue_as :default

  def perform
    Tag.unused.delete_all
  end
end
