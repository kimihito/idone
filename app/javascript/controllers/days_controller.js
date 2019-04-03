import { Controller } from "stimulus"
import 'dayjs/locale/ja'
import dayjs from 'dayjs'
import relativeTime from 'dayjs/plugin/relativeTime'

dayjs.extend(relativeTime)

export default class extends Controller {
  static targets = [ "date" ]
  connect() {
    console.log(this.dateTarget.textContent)
    this.dateTarget.textContent = 'hi'
  }

  relativeTime(date) {
    this.timeAgoTarget.textContent = dayjs().from(dayjs(date))
  }
}