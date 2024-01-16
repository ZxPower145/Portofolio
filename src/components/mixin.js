import {BCardBody} from "bootstrap-vue";

export default {
  data() {
    return {
      cardPos: {
        clientX: undefined,
        clientY: undefined,
        movementX: 0,
        movementY: 0
      },
      elementBaseHeight: 0,
      bodyBaseHeight: 0,
      footerBaseHeight: 0,
    }
  },
  methods: {
    getHeight(element) {
      const bodyE = element.querySelector('.card-body')
      const footerE = element.querySelector('.card-footer')
      this.elementBaseHeight = element.offsetHeight
      this.bodyBaseHeight = bodyE.offsetHeight
      this.footerBaseHeight = footerE.offsetHeight
    },
    dragMouseDown(event, element) {
      let pos = this.cardPos
      if (event.target.id === 'card-header') {
        event.preventDefault(); // Prevent default to avoid unwanted behavior on touch devices
        element.style.position = 'absolute';
        pos.clientX = event.clientX || event.touches[0].clientX;
        pos.clientY = event.clientY || event.touches[0].clientY;
        document.onmousemove = (event) => this.elementDrag(event, element, pos);
        document.ontouchmove = (event) => this.elementDrag(event, element, pos);
        document.onmouseup = this.closeDragElement;
        document.ontouchend = this.closeDragElement;
      }
    },
    elementStyle(element, cardBody, press) {
      const cardFooter = element.querySelector('.card-footer')
      if (press === 'down'){
        element.style.transition = 'height 1s ease'
        cardBody.style.transition = 'filter 1s ease, height 1s ease, padding 1s ease'
        element.style.padding = '0px'
        element.style.height = '50px'
        cardBody.style.padding = '0px'
        cardBody.style.height = '0px'
        cardFooter.style.padding = '0px'
        cardFooter.style.height = '0px'
        cardBody.style.filter = 'blur(5px)'
      }
      if (press === 'up') {
        element.style.height = `${this.elementBaseHeight}px`
        cardBody.style.height = `${this.bodyBaseHeight}px`
        cardFooter.style.height = `${this.footerBaseHeight}px`
        cardBody.style.padding = '10px'
        cardFooter.style.padding = '10px'
        cardBody.style.filter = 'blur(0px)'
      }
    },
    elementDrag(event, element, pos) {
      event.preventDefault(); // Prevent default to avoid unwanted behavior on touch devices
      pos.movementX = pos.clientX - (event.clientX || event.touches[0].clientX);
      pos.movementY = pos.clientY - (event.clientY || event.touches[0].clientY);
      pos.clientX = event.clientX || event.touches[0].clientX;
      pos.clientY = event.clientY || event.touches[0].clientY;


      // set the element's new position:
      element.style.top = element.offsetTop - pos.movementY + 'px';
      element.style.left = element.offsetLeft - pos.movementX + 'px';
    },
    closeDragElement() {
      document.onmouseup = null;
      document.ontouchend = null;
      document.onmousemove = null;
      document.ontouchmove = null;
    },
  },
};