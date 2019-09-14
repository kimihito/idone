import * as Stimulus from 'stimulus'

export default class extends Stimulus.Controller {
  static targets = ['item', 'content']
  readonly itemTarget!: Element
  readonly itemTargets!: Element[]
  readonly hasItemTargets!: boolean

  readonly contentTarget!: Element
  readonly contentTargets!: Element[]
  readonly hasContentTargets!: boolean


  initialize() {
    this.showCurrentItem()
  }

  public showCurrentItem() {
    const url = this.itemTargets[this.data.get('index')].dataset.tabUrl
    fetch(url).then(response => response.text()).then((data) => {
      this.contentTarget.innerHTML = data
      this.itemTargets.forEach((el, i) => {
        el.classList.toggle('selected', this.index == i)
      })
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

