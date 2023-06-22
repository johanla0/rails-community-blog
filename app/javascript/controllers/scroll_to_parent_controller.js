/* eslint-disable class-methods-use-this */
/* eslint-disable no-underscore-dangle */
import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['comment'];

  scroll(e) {
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

  highlightParentComment(e) {
    this._removeHighlighting();
    const card = e.currentTarget.closest('.card');
    card.classList.add('border-primary');
  }
}
