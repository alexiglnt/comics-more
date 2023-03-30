import Vue from 'vue';

Vue.directive('canva', {
  inserted: function(el, binding) {
    const canvas = document.createElement('canvas');
    const context = canvas.getContext('2d');
    const image = new Image();

    image.onload = function() {
      canvas.width = image.width;
      canvas.height = image.height;
      context.drawImage(image, 0, 0);
      el.parentNode.replaceChild(canvas, el);
    };

    image.src = binding.value;
  }
});
