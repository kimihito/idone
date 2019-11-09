import * as Stimulus from 'stimulus'
import Choices from 'choices.js'
import feather from 'feather-icons'

export default class extends Stimulus.Controller {
  public connect() {
    new Choices(<HTMLInputElement>this.element, {
      removeItemButton: true,
      duplicateItemsAllowed: false,
      classNames: {
        containerInner: 'form-control'
      },
      callbackOnCreateTemplates: template => {
        return {
          item: (_, data) => {
            return template(`
              <span class='Label Label--outline bg-blue-light border-white-fade rounded-1 text-bold mr-1 mb-1'
                data-item
                data-id=${data.id}
                data-value=${data.value}
              >
                ${data.label}

                ${feather.icons.x.toSvg({'width': 10, 'height': 10, 'data-deletable': '', 'data-button': '', 'class': 'choices__remove-tag'})}
              </span>
            `)
          }
        }
      }
    })
  }
}