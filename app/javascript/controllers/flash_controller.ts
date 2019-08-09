import * as Stimulus from 'stimulus'

export default class extends Stimulus.Controller {
  public dismiss() {
    this.element.setAttribute('style', "display: none;")
  }
}
