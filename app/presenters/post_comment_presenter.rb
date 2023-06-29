# frozen_string_literal: true

class PostCommentPresenter < SimpleDelegator
  def author
    user.decorate.name
  end
end
