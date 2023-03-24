import { Application } from "@hotwired/stimulus"
import AnimatedNumber from 'stimulus-animated-number'
import Notification from 'stimulus-notification'
import { Confetti } from "stimulus-confetti"
const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
application.register('animated-number', AnimatedNumber)
application.register('notification', Notification)
application.register('confetti', Confetti)
export { application }
