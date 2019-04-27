import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['errors']

  onSaveFail(event) {
    const [data, status, xhr] = event.detail
    this.errorsTarget.innerHTML(xhr.response)
  }
}