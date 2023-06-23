module PostPresenter
  AVERAGE_READING_RATE = 183.0
  def time_to_read
    (body.split.count / AVERAGE_READING_RATE).ceil
  end

  def author
    creator&.name || I18n.t('unknown_author')
  end

  def likes_count
    post_likes.count
  end
end
