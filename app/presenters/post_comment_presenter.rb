module PostCommentPresenter
  def author
    user&.name || I18n.t('unknown_author')
  end
end
