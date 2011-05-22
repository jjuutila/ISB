function mycarousel_initCallback(carousel)
{
    // Disable autoscrolling if the user clicks the prev or next button.
    carousel.buttonNext.bind('click', function() {
        carousel.startAuto(0);
    });

    carousel.buttonPrev.bind('click', function() {
        carousel.startAuto(0);
    });

    // Pause autoscrolling if the user moves with the cursor over the clip.
    carousel.clip.hover(function() {
        carousel.stopAuto();
    }, function() {
        carousel.startAuto();
    });
};
    
jQuery(document).ready(function() {
  $('#supporter-carousel').show();
  $('#supporter-carousel').jcarousel({
      auto: 4,
      wrap: 'last'
  });
  
  hiConfig = {
    sensitivity: 8,
    interval: 100,
    timeout: 300,
    over: function() {
      $(this).addClass("subhover");
      $(this).find("img").attr('src', '/images/triangle_blue.png');
      $(this).find("ul.subnav").slideDown('fast').show(); //Drop down the subnav on click
    },
    out: function() {
      $(this).find("ul.subnav").hide();
      $(this).find("img").attr('src', '/images/triangle_white.png');
      $(this).removeClass("subhover");
      
    }
  }
  
  $("ul.subnav").parent().hoverIntent(hiConfig)
  $("ul.subnav").parent().append("<img src='/images/triangle_white.png' />");
  $("ul.subnav").parent().hoverIntent(hiConfig)
  $("ul.subnav").parent().children('a').replaceWith(function(link){
    return $(this).text();
  });
}); 