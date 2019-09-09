import * as Stimulus from 'stimulus'

export default class extends Stimulus.Controller {
  static targets = ['item']
  readonly itemTarget!: Element
  readonly itemTargets!: Element[]
  readonly hasItemTargets!: boolean


  initialize() {
    this.showCurrentItem()
  }

  public showCurrentItem() {
    this.itemTargets.forEach((el, i) => {
      el.classList.toggle('selected', this.index == i)
    })
  }

  public selectedItem(event) {
    event.preventDefault()
    this.index = this.itemTargets.indexOf(event.currentTarget)
  }

  get index() {
    return parseInt(this.data.get('index'))
  }

  set index(value) {
    this.data.set('index', value.toString())
    this.showCurrentItem()
  }
}

