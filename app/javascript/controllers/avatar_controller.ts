import * as Stimulus from 'stimulus'
import Avatars from '@dicebear/avatars'
import sprites from '@dicebear/avatars-identicon-sprites'


export default class extends Stimulus.Controller {
  public connect() {
    if (!(this.element instanceof HTMLImageElement)) return
    if (this.element.getAttribute('data-src')) return
    const seed: string = this.data.get('seed')
    const avatars = new Avatars(sprites())
    const svg = avatars.create(seed)
    this.element.setAttribute('data-src', `data:image/svg+xml, ${encodeURIComponent(svg)}`)
  }
}