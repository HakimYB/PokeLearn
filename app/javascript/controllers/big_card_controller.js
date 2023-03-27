import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="big-card"
export default class extends Controller {
  static targets = ["image", "name", "types", "details", "card"]
  connect() {
    console.log("hey");
    console.log(this.element)
    console.log(this.imageTarget)
    console.log(this.nameTarget)
    console.log(this.typesTarget)
    console.log(this.detailsTarget)
  }

  showBigCard(event) {
    event.preventDefault()
    console.log("helloooooo")
    // console.log(event.currentTarget)
    console.log(this.imageTarget)
    fetch(event.currentTarget.href, {headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      this.cardTarget.outerHTML = data
    })
  }

}
