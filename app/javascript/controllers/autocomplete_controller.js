import { Controller } from 'stimulus'

import Tribute from 'tributejs'

export default class extends Controller {
  static targets = ["rawBody"]

  initialize() {
    const tribute = new Tribute({
      trigger: '#',
      values: [
        {key: 'Phil Heartman', value: 'pheartman'},
        {key: 'Gordon Ramsey', value: 'gramsey'}
      ],
    })
    tribute.attach(this.rawBodyTarget)
  }
}