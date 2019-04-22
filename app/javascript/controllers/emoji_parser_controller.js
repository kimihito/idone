import { Controller } from 'stimulus'
import twemoji from 'twemoji'

export default class extends Controller {
  connect() {
    twemoji.parse(this.element, { folder: 'svg', ext: '.svg'})
  }
}