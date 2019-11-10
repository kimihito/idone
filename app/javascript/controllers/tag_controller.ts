import * as Stimulus from 'stimulus'
import Choices from 'choices.js'
import * as feather from 'feather-icons'

import i18next from 'i18next'

i18next.init({
  fallbackLng: 'ja',
  resources: {
    ja: {
      translation: {
        'add': "エンターキーで {{value}} を追加する",
        'errors': {
          'taken': 'すでに登録されているタグです'
        }
      }
    }
  }
})

export default class extends Stimulus.Controller {
  public connect() {
    new Choices(<HTMLInputElement>this.element, {
      removeItemButton: true,
      duplicateItemsAllowed: false,
      addItemText: (value) => {
        return i18next.t('add', { value: value })
      },
      uniqueItemText: () => {
        return i18next.t('errors.taken')
      },
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