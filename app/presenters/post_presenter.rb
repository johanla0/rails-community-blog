module PostPresenter
  AVERAGE_READING_RATE = 183.0
  def time_to_read
    (body.split.count / AVERAGE_READING_RATE).ceil
  end

  def author
    user.name.presence || I18n.t('removed_author')
  end
end
