import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static values = { delay: { type: Number, default: 5000 } }

  connect() {
    this.timeout = setTimeout(() => this.close(), this.delayValue)
  }

  disconnect() {
    console.log("disconnect")
    clearTimeout(this.timeout)
  }

  close() {
    this.element.addEventListener("transitionend", () => this.element.remove(), { once: true })
    this.element.classList.add("opacity-0")
  }
}
