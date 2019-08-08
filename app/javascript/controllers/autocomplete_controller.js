import { Controller } from 'stimulus'

import Tribute from 'tributejs'

import { throttle } from 'lodash'

import { extractHashtags } from 'twitter-text'

const URL = "/my/projects.json"

let projects = []
let projectNames = []


export default class extends Controller {
  static targets = ["rawBody", "projectId", "error"]
  initialize() {
    this.validProject = throttle(this.validProject, 1000)
  }

  async connect() {
    projects = await this.fetchProjects()
    projectNames = projects.map(project => { return project.attributes.title })

    this.tribute = new Tribute({
      trigger: '#',
      values: projects,
      selectTemplate: (item) => { return `#${item.original.attributes.title}` },
      lookup: (project, _mentionText) => { return project.attributes.title },
    })
    this.tribute.attach(this.rawBodyTarget)
    this.errorTarget.style.display = 'none'
  }

  disconnect() {
    this.tribute.detach(this.rawBodyTarget)
  }

  async fetchProjects() {
    try {
      const response = await fetch(`${URL}`);
      const json = await response.json();
      return json.data;
    }
    catch (error) {
      console.error('error:', error);
    }
  }

  validProject(event) {
      if(this.rawBodyTarget.value.length < 2) {
        this.errorTarget.style.display = 'none'
        event.preventDefault()
        return
      }
      const hashTags = extractHashtags(this.rawBodyTarget.value)
      const validProjectNames = hashTags.filter(tag => { return projectNames.includes(tag) })
      if(!validProjectNames.length) {
        this.appendErrorMessage('参加しているプロジェクトがありません')
        this.clearProjectId()
        event.preventDefault();
        return
      }
      if (validProjectNames.length > 1) {
        this.appendErrorMessage('複数のプロジェクトに一つの投稿はできません')
        this.clearProjectId()
        event.preventDefault();
        return
      }
      this.errorTarget.style.display = 'none'
      this.errorTarget.innerText = ''
      this.projectIdTarget.value  = projects.find(project => { return project.attributes.title === validProjectNames[0] }).id
      event.preventDefault()
  }

  appendErrorMessage(text) {
    this.errorTarget.style.display = ''
    this.errorTarget.innerText = text
  }

  clearProjectId() {
    this.projectIdTarget.value = ''
  }
}