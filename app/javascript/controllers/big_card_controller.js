import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="big-card"
export default class extends Controller {
  static targets = ["card"]
  connect() {
    console.log("hey");
    console.log(this.cardTarget)
  }

  showBigCard(event) {
    event.preventDefault()
    console.log("helloooooo")
    // console.log(event.currentTarget)
    fetch(event.currentTarget.href, {headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      this.cardTarget.outerHTML = data
    })
  }

}
