import * as Stimulus from 'stimulus'

import Tribute, { TributeCollection, TributeItem } from 'tributejs'

import { Deserializer as JSONAPIDeserializer, Deserializer, DeserializerConstructor } from 'jsonapi-serializer'

const URL = "/my/tags.json"

export default class extends Stimulus.Controller {
  tribute: Tribute<{}>
  tags: TributeItem<{}>[]

  public async connect() {
    await this.tagApi(URL)
      .then(json => {
        return new JSONAPIDeserializer({keyForAttribute:"camelCase"}).deserialize(json, (err, tags) => {
          if(err) {
            throw err
          }
          this.tags = tags
        })
      })
    this.tribute = new Tribute({
      trigger: '#',
      values: this.tags,
      fillAttr: 'name',
      lookup: 'name'
    })

    this.tribute.attach(this.element)
  }

  public disconnect() {
    this.tribute.detach(this.element)
  }

  tagApi<T>(url: string): Promise<T> {
    return fetch(url).then(response => {
      if(!response.ok) {
        throw new Error(response.statusText)
      }
      return response.json() as Promise<T>
    })
  }
}
