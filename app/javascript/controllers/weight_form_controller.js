import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weight-form"
export default class extends Controller {
  static targets = ["input", "unit"]
  static values = { defaultUnit: String }

  connect() {
    let defaultUnit = this.defaultUnitValue;
    
    if (defaultUnit != this.unitTarget.value) {
      this.changeUnit();
      this.convert();
    }
  }

  changeUnit() {
    const currentUnit = this.unitTarget.value;
    if (currentUnit === 'lbs') {
      this.unitTarget.value = 'kg';
    } else {
      this.unitTarget.value = 'lbs';
    }
  }

  convert() {
    const weight = parseFloat(this.inputTarget.value);
    const currentUnit = this.unitTarget.value;
    if (!isNaN(weight)) {
      if (currentUnit === 'lbs') {
        this.inputTarget.value = (weight * 2.20462).toFixed(2);  // Converting kg to lbs
      } else {
        this.inputTarget.value = (weight / 2.20462).toFixed(2);  // Converting lbs to kg
      }
    }
  }
}
