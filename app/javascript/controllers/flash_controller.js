import { Controller } from "stimulus"

export default class extends Controller {
  dismiss() {
    this.element.style.display = 'none';
  }
}
