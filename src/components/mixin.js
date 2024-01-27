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
    moveGameBtn(game, direction) {
      const cardBody = this.$refs.cardBody
      const gameFolderCard = this.$refs.card
      const gameBtn = game.querySelector('.game')

      gameBtn.style.transition = 'transform 1s cubic-bezier(0.37, 0, 0.63, 1) 0s, ' +
          'background-color 1.5s cubic-bezier(0.37, 0, 0.63, 1) 0s, ' +
          'box-shadow 1.5s cubic-bezier(0.37, 0, 0.63, 1) 0s'

      if (direction === 'up') {
        cardBody.style.overflow = 'visible'
        gameFolderCard.style.overflow = 'visible'
        game.style.overflow = 'visible'
        gameBtn.style.transform = 'translateX(300px)'

        switch (gameBtn.id.toString()) {
          case 'guess':
            gameBtn.style.boxShadow = '0 0 30px 5px rgba(10, 202, 112, 1)'
            gameBtn.style.backgroundColor = 'rgba(0, 73, 49, 0.6)'
            break
          case 'pig':
            gameBtn.style.boxShadow = '0 0 30px 5px #f914ff'
            gameBtn.style.backgroundColor = 'rgba(157, 2, 161, 0.6)'
            break
          case 'tictactoe':
            gameBtn.style.boxShadow = '0 0 30px 5px rgb(76, 133, 230)'
            gameBtn.style.backgroundColor = 'rgba(45, 76, 128, 0.6)'
            break
          case 'shoot':
            gameBtn.style.boxShadow = '0 0 30px 5px rgb(230, 21, 21)'
            gameBtn.style.backgroundColor = 'rgba(186, 17, 17, 0.6)'
            break
          default:
            console.error(`We ran out of ${gameBtn}`)
        }
      }
      else {
        gameBtn.style.transform = 'translateX(0)'
        gameBtn.style.backgroundColor = 'rgba(255, 255, 255, 0.1)'
        gameBtn.style.boxShadow = '0 0 30px 5px black'
      }
    },
    elementStyle(element, press, isGameOpen) {
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