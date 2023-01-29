import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="removals"
export default class extends Controller {
  remove() {
    // Este método elimina al mensaje flash del DOM cuando termina la animación, es decir, cuando su opacidad llega a cero
    this.element.remove()
  }
}