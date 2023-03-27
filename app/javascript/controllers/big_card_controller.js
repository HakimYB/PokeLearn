import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="big-card"
export default class extends Controller {
  connect() {
    console.log("hey");
  }
}
