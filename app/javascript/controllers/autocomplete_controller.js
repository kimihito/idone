import { Controller } from 'stimulus'

import Tribute from 'tributejs'

import Qs from 'qs'

const URL = "/my/projects.json"

export default class extends Controller {
  static targets = ["rawBody"]

  connect() {
    this.tribute = new Tribute({
      trigger: '#',
      values: this.searchProjects.bind(this),
      lookup: 'title',
      fillAttr: 'title'
    })
    this.tribute.attach(this.rawBodyTarget)
  }

  disconnect() {
    this.tribute.detach(this.rawBodyTarget)
  }

  searchProjects(query, cb) {
    const stringifiedParams = Qs.stringify({q: query})
    fetch(`${URL}?${stringifiedParams}`).then(response => {
      return response.json()
    }).then(json => {
      console.log(json.data)
      return cb(json.data.map(d => { return d.attributes }))
    }).catch(ex => {
      console.error('error', ex)
      return cb([])
    })
  }
}