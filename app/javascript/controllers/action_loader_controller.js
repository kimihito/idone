import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "action-loader" ]

  initialize() {
    this.load()
  }

  load() {
    this.element.innerHTML = "loading...."
    fetch(this.data.get('url'))
      .then(response => response.text())
      .then(html => {
        this.element.innerHTML = html
      })
  }
}