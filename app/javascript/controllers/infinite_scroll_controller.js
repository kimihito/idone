import { Controller } from 'stimulus'
const InfiniteScroll = require('infinite-scroll')

export default class extends Controller {
  connect() {
    new InfiniteScroll(this.element, {
      path: '.next_page',
      append: '.action',
      hideNav: '.paginate-container',
      history: false
    })
  }
}