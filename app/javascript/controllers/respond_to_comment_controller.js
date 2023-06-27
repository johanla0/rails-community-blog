/* eslint-disable class-methods-use-this */
/* eslint-disable no-underscore-dangle */
import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'comment',
  ];

  scrollToParent(e) {
    e.preventDefault();
    const anchor = e.currentTarget.href.split('#').pop();
    const scrollTo = document.getElementById(anchor);
    if (scrollTo === null) return;

    scrollTo.scrollIntoView();
  }

  _removeHighlighting() {
    this.commentTargets.forEach((card) => {
      card.classList.remove('border-primary');
    });
  }

  _highlightCommentCard(card) {
    card.classList.add('border-primary');
  }

  respond(e) {
    this._removeHighlighting();

    const parentCommentCard = e.currentTarget.closest('.card');
    this._highlightCommentCard(parentCommentCard);

    parentCommentCard.nextSibling.scrollIntoView();
  }
}
