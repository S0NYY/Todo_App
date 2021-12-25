class PostModerationJob < ApplicationJob
  queue_as :posts

  def perform(*args)
    post = args.first
    post.process_on_moderation!
  end
end
