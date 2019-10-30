import * as Stimulus from 'stimulus'
import Tagify from '@yaireo/tagify'

export default class extends Stimulus.Controller {
  public connect() {
    new Tagify(<HTMLInputElement>this.element)
  }
}