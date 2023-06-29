# frozen_string_literal: true

module PostPresenter
  AVERAGE_READING_RATE = 183.0
  def time_to_read
    (body.split.count / AVERAGE_READING_RATE).ceil
  end

  def author
    creator.name
  end

  delegate :count, to: :likes, prefix: true
  delegate :count, to: :comments, prefix: true
end
