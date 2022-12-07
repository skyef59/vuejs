<script setup>
  import { BIconPauseBtn, BIconPlayBtn } from 'bootstrap-icons-vue';
  import {nextTick, ref} from 'vue'

  const props = defineProps({
      heigthBox: {type: Number, default: 200},
      widthBox: {type: Number, default: 200},
      speed: {type: Number, default: 100},
  });

  const lengthOfSnake = 5;
  var movement = 'rigth';
  var autorizeToKeyDown = true;
  var inProgress = ref(false);

  nextTick(() => {
    var snake = document.getElementById('snake');
    var left = 0;

    generateRandomApple();

    for (let i = 0; i < lengthOfSnake; i ++) {
      var bit = document.createElement("div");
      bit.id = 'bit-' + i;
      bit.className = "snake-bit";
      bit.style.left = left + "px";
      bit.style.top = "0px";
      snake.appendChild(bit);
      left += 10;
    }
  })

  document.addEventListener("keydown", event => {
    if (!autorizeToKeyDown && event.code != 'KeyP') {
      return;
    }

    switch (event.code) {
      case 'KeyA':
        movement = movement == 'rigth' ? 'rigth' : 'left'; break;
      case 'KeyS':
        movement = movement == 'up' ? 'up' : 'down'; break;
      case 'KeyD':
        movement = movement == 'left' ? 'left' : 'rigth'; break;
      case 'KeyW':
        movement = movement == 'down' ? 'down' : 'up'; break;
      case 'KeyP':
        inProgress.value = !inProgress.value; break;
    }

    autorizeToKeyDown = false;
  });

  const resolveMovementOfFirstBit = (bit) => {
    let apple = document.getElementById('apple');
    let position = 0;

    switch (movement) {
      case 'left':
        position = parseInt(bit.style.left) == 0 ? props.widthBox : parseInt(bit.style.left);
        bit.style.left = (position - 10) + "px"; 
        break;
      case 'down':
        position = parseInt(bit.style.top) == (props.heigthBox - 10) ? -10 : parseInt(bit.style.top);
        bit.style.top = (position + 10) + "px"; 
        break;
      case 'rigth':
        position = parseInt(bit.style.left) == (props.widthBox - 10) ? -10 : parseInt(bit.style.left);
        bit.style.left = (position + 10) + "px"; 
        break;
      case 'up':
        position = parseInt(bit.style.top) == 0 ? props.heigthBox : parseInt(bit.style.top);
        bit.style.top = (position - 10) + "px"; 
        break;
    }

    //Si la serpent se mange #cannibal
    for (var i = document.getElementById('snake').childNodes.length - 2; i >= 0; i --) {
      var childBit = document.getElementById('bit-' + i);
      if (childBit.style.left == bit.style.left && childBit.style.top == bit.style.top) {
        alert("Cannibalisme !");
        location.reload();
      }
    }

    //Si le serpent mange une pomme
    if (apple.style && bit.style.left == apple.style.left && bit.style.top == apple.style.top) {
      apple.remove();
      generateRandomApple();
      createBitOfSnake();
    }

    autorizeToKeyDown = true;
  }

  const moveSnake = () => {
    if (!inProgress.value) {
      return;
    }

    let childrens = document.getElementById('snake').childNodes;
    let lastStyles = null;

    for (var i = childrens.length - 1; i >= 0; i --) {
      var bit = document.getElementById('bit-' + i);

      if (!lastStyles) {
        lastStyles = {left: bit.style.left, top: bit.style.top};
        resolveMovementOfFirstBit(bit); 
      } else {
        let tpmLastStyle = {left: bit.style.left, top: bit.style.top};

        bit.style.left = lastStyles.left;
        bit.style.top = lastStyles.top;

        lastStyles = tpmLastStyle;
      }
    }
  }

  const createBitOfSnake = () => {
    let snake = document.getElementById('snake');
    let childrens = document.getElementById('snake').childNodes;
    let firstBit = childrens[childrens.length - 1];
    
    var bit = document.createElement("div");
    bit.id = 'bit-' + childrens.length;
    bit.className = "snake-bit";
    bit.style.left = firstBit.style.left;
    bit.style.top = firstBit.style.top;
    snake.appendChild(bit);
  }

  const generateRandomApple = () => {
    let top = Math.floor(Math.random() * (props.heigthBox / 10)) * 10;
    let left = Math.floor(Math.random() * (props.widthBox / 10)) * 10;

    var apple = document.createElement("div");
    apple.id = 'apple';
    apple.className = 'apple';
    apple.style.left = left + "px";
    apple.style.top = top + "px";
    document.getElementById('map-zone').appendChild(apple);
  }

  setInterval(() => moveSnake(), props.speed);
</script>

<template>
    <div 
      class="border border-primary" 
      id="map-zone" 
      :style="'height:' + props.heigthBox + 'px;' + 'width:' + props.widthBox + 'px;' + 'position: relative'"
    >
      
      <div id="snake"></div>

      <span 
        class="h4 opacity-50" 
        style="position: absolute; right: 5px; bottom: -6px; z-index: 5; cursor: pointer;"
        @click="inProgress = !inProgress"
      >
          <BIconPauseBtn v-if="inProgress" />
          <BIconPlayBtn  v-if="!inProgress" />
      </span>
    </div>
</template>

<style>
  .snake-bit {
    height: 10px;
    width: 10px;
    background: rgb(15, 147, 255);
    position: absolute;
    z-index: 2;
    border-radius: 40%;
  }

  .apple {
    height: 10px;
    width: 10px;
    background: lime;
    position: absolute;
    border-radius: 100%;
    z-index: 1;
  }
</style>