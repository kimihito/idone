import { Controller } from 'stimulus'

import Tribute from 'tributejs'

import Qs from 'qs'

import { throttle, isEmpty } from 'lodash'

import { extractHashtags } from 'twitter-text'

const URL = "/my/projects.json"

let projects = []
let projectNames = []


export default class extends Controller {
  static targets = ["rawBody", "projectId", "error"]
  initialize() {
    this.validProject = throttle(this.validProject, 1000)
    console.log(this.validProject)
  }

  async connect() {
    await this.fetchProjects()
    projectNames = projects.map(project => { return project.attributes.title })

    this.tribute = new Tribute({
      trigger: '#',
      values: projects,
      selectTemplate: (item) => { return `#${item.original.attributes.title}` },
      lookup: (project, mentionText) => { return project.attributes.title },
    })
    this.tribute.attach(this.rawBodyTarget)
    this.errorTarget.style.display = 'none'
  }

  disconnect() {
    this.tribute.detach(this.rawBodyTarget)
  }

  fetchProjects() {
    return fetch(`${URL}`).then(response => {
      return response.json()
    }).then(json => {
      projects = json.data
    }).catch(error => {
      console.error('error:', error)
    })
  }

  validProject(event) {
      console.log(this.tribute.isActive)
      if(this.rawBodyTarget.value.length < 2) {
        this.errorTarget.style.display = 'none'
        event.preventDefault()
        return
      }
      const hashTags = extractHashtags(this.rawBodyTarget.value)
      const validProjectNames = hashTags.filter(tag => { return projectNames.includes(tag) })
      if(!validProjectNames.length) {
        this.appendErrorMessage('参加しているプロジェクトがありません')
        event.preventDefault();
        return
      }
      if (validProjectNames.length > 1) {
        this.appendErrorMessage('複数のプロジェクトに一つの投稿はできません')
        event.preventDefault();
        return
      }
      this.errorTarget.style.display = 'none'
      this.errorTarget.innerText = ''
      // this.projectIdTarget.value =
      event.preventDefault()
  }

  appendErrorMessage(text) {
    this.errorTarget.style.display = ''
    this.errorTarget.innerText = text
  }
}