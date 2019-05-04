import { Controller } from 'stimulus'
import feather from 'feather-icons'

export default class extends Controller {
  static targets = ['errors']

  onSaveFail(event) {
    const [data, status, xhr] = event.detail
    this.errorsTarget.innerHTML = xhr.response
    feather.replace({'width': 18, 'height': 18})
  }
}