import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ['template', 'textfields']

    connect() {
        this.addField()
    }

    remove(event) {
        event.target.closest('.wrapper').remove();
    }

    addField(event) {
        if (event) {
            event.preventDefault();
        }

        var content = this.templateTarget.innerHTML;
        this.textfieldsTarget.insertAdjacentHTML('beforebegin', content);
    }
}