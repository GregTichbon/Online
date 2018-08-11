/*
 * Image Cover jQuery Plugin
 * Version 1.0.1
 * https://github.com/jordicuenca/image-cover
 * -
 * Copyright (c) 2016 Jordi Cuenca Martín <jordicuenca@gmail.com>
 * Dual licensed under the MIT and GPL licenses.
 * http://docs.jquery.com/License
 */

$.fn.imageCover = function( option ){

  /* Getting the plugin options */

  if(option){
    var carousel = option.carousel;
  }

  var $this = $(this),

  before = function(){

    /* Preventing possible inherited problems */

    $($this).each(function(){

      $(this).css({
        'display'   : 'none',
        'width'     : 'auto',
        'height'    : 'auto',
        'max-width' : 'none !important',
        'max-height': 'none !important'
      }).hide();

      /* Hide the overflow image with css in container */

      $(this).parent().css({
        'overflow': 'hidden'
      });

      /* Support to element above image */

      $(this).prev().css({
        'position': 'absolute',
        'z-index': '1'
      });

    });

  },

  loaded = function(){

    $($this).each(function(){

      /* Getting the container and image sizes */

      var parent_width  = $(this).parent().width();
      var parent_height = $(this).parent().height();
      var image_width   = $(this).width();
      var image_height  = $(this).height();

      /* Resizing image using the container width like a reference
       * size to resizing */

      var image_width_resize  = parent_width;
      var image_height_resize = ( parent_width / image_width ) * image_height;

      /* Checking that the new image height is equal or more than
       * the container height. */

      if ( image_height_resize < parent_height || image_width_resize < parent_width ) {

        /* If new height image is less than container height, we
         * use the heght container like a size reference to resize
         * image again */

        var image_height_resize = parent_height;
        var image_width_resize 	= ( parent_height / image_height ) * image_width;

      }

      /* Define the image margin to centrate in container */

      var margin_left = ( parent_width - image_width_resize ) / 2;
      var margin_top  = ( parent_height - image_height_resize ) / 2;

      /* Resizing and apply new marings in image with css */

      $(this).css({
        'margin-left' : margin_left + 'px',
        'margin-top'  : margin_top + 'px',
        'width'       : image_width_resize + 'px',
        'height'      : image_height_resize + 'px',
        'max-width'   : '1000%'
      }).fadeIn();

    });

  };

  $(document).ready(before);
  $(window).load(loaded).resize(loaded);

  /* Support to can use the plugin in Bootstrap carousel */

  if (carousel) {
    $(carousel).on('slide.bs.carousel', function() {
      loaded();
    });
  }

};

/* Using default class */

$(function(){
  $('.image-cover').imageCover();
});
