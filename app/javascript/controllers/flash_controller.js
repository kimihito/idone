import { Controller } from "stimulus"
import octicons from 'octicons'

export default class extends Controller {
  static targets = ["close"]
  connect() {
    const closeElement = this.closeTarget
    closeElement.innerHTML = octicons.x.toSVG({"aria-label": 'Close'})
  }

  dismiss() {
    this.element.style.display = 'none';
  }
}
