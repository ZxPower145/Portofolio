import axios from "axios";

export default {
  data() {
    return {
      cardPos: {
        clientX: undefined,
        clientY: undefined,
        movementX: 0,
        movementY: 0,
      },
    }
  },
  methods: {
    async getProjects(category) {
      this.$store.commit('setIsLoading', [true, category])
      console.log(category)
      try {
        const response = await axios.get(`/api/v1/projects/category/${category}`)
        this.$store.commit('setIsLoading', false)
        return JSON.parse(JSON.stringify(response.data))
      } catch (error) {
        console.error('Error fetching bio:', error);
      }
    },
    getLink(slug) {
      for (let i = 0; i<= this.projects.length; i++){
        if (this.projects[i].slug === slug) {
          if (this.projects[i].github) {
            return this.projects[i].github.toString()
          }
          else {
            console.error(`The project ${this.projects[i].name} doesn't have a github link!`)
          }
        }
      }
    },
    moveElementBtn(element, direction) {
      const cardBody = this.$refs.cardBody
      const elementFolderCard = this.$refs.card
      const elementBtn = element.querySelector('.elementBtn')

      elementBtn.style.transition = 'transform 1s cubic-bezier(0.37, 0, 0.63, 1) 0s, ' +
          'background-color 1.5s cubic-bezier(0.37, 0, 0.63, 1) 0s, ' +
          'box-shadow 1.5s cubic-bezier(0.37, 0, 0.63, 1) 0s'

      if (direction === 'up') {
        cardBody.style.overflow = 'visible'
        elementFolderCard.style.overflow = 'visible'
        element.style.overflow = 'visible'
        elementBtn.style.transform = 'translateX(300px)'

        switch (elementBtn.id) {
          case 'guess':
            elementBtn.style.boxShadow = '0 0 30px 5px rgba(10, 202, 112, 1)'
            elementBtn.style.backgroundColor = 'rgba(0, 73, 49, 0.6)'
            break
          case 'piggame':
            elementBtn.style.boxShadow = '0 0 30px 5px #f914ff'
            elementBtn.style.backgroundColor = 'rgba(157, 2, 161, 0.6)'
            break
          case 'tictactoe':
            elementBtn.style.boxShadow = '0 0 30px 5px rgb(76, 133, 230)'
            elementBtn.style.backgroundColor = 'rgba(45, 76, 128, 0.6)'
            break
          case 'shoot':
            elementBtn.style.boxShadow = '0 0 30px 5px rgb(230, 21, 21)'
            elementBtn.style.backgroundColor = 'rgba(186, 17, 17, 0.6)'
            break
          case 'invoice':
            elementBtn.style.boxShadow = '0 0 30px 5px #8a8130'
            elementBtn.style.backgroundColor = 'rgba(176, 166, 72, 0.6)'
            break
          case 'webstore':
            elementBtn.style.boxShadow = '0 0 30px 5px #27e669'
            elementBtn.style.backgroundColor = 'rgba(32, 176, 82, 0.6)'
            break
          case 'student':
            elementBtn.style.boxShadow = '0 0 30px 5px #931be3'
            elementBtn.style.backgroundColor = 'rgba(103, 16, 161, 0.6)'
            break
          case 'chat':
            elementBtn.style.boxShadow = '0 0 30px 5px #18d6d6'
            elementBtn.style.backgroundColor = 'rgba(17, 150, 150, 0.6)'
            break
          default:
            console.error(`We ran out of ${elementBtn}`)
        }
      }
      else {
        elementBtn.style.transform = 'translateX(0)'
        elementBtn.style.backgroundColor = 'rgba(255, 255, 255, 0.1)'
        elementBtn.style.boxShadow = '0 0 30px 5px black'
      }
    },
    elementStyle(element, press, isGameOpen, isHome) {
      const cardBody = this.$refs.cardBody
      const cardFooter = this.$refs.cardFooter
      if (press === 'down'){
        element.style.transition = 'filter 1s ease, ' +
          'grid-template-rows 1s ease, ' +
          'border 1s ease, ' +
          'height 1s ease'
        cardBody.style.transition = 'all 1s ease'
        cardFooter.style.transition = 'all 1s ease'
        cardBody.style.filter = 'blur(5px)'
        element.style.gridTemplateRows = '10% 0% 0%'
        element.style.overflow = 'hidden'
        cardBody.style.overflow = 'hidden'
        cardBody.style.padding = '0'
        cardFooter.style.padding = '0'
      }
      if (press === 'up') {
        element.style.gridTemplateRows = '10% 80% 10%'
        element.style.overflow = 'auto'
        cardBody.style.filter = 'blur(0px)'
        cardFooter.style.padding = '10px'
        if (!isGameOpen) {
          cardBody.style.padding = '10px'
        }
        if (isHome) {
          cardBody.style.overflow = 'scroll'
        }
      }
    },
    dragMouseDown(event, element, pos=this.cardPos) {
      if (event.target.id === 'card-header' ||
        event.target.id === 'toolbar' ||
        event.target.id === 'title') {
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