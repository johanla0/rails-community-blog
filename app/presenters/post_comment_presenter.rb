module PostCommentPresenter
  def author
    user.name.presence || I18n.t('unknown_author')
  end
end
