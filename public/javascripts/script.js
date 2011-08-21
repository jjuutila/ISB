function mycarousel_initCallback(carousel)
{
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
      wrap: 'last',
      initCallback: mycarousel_initCallback
  });
  
  hiConfig = {
    sensitivity: 8,
    interval: 100,
    timeout: 300,
    over: function() {
      $(this).addClass("subhover");
      $(this).find("img").attr('src', '/images/triangle_blue.png');
      $(this).find("ul.subnav").slideDown('fast').show();
    },
    out: function() {
      $(this).find("ul.subnav").hide();
      $(this).find("img").attr('src', '/images/triangle_white.png');
      $(this).removeClass("subhover");
    }
  }
  
  $("ul.subnav").parent().hoverIntent(hiConfig);
  $("ul.subnav").parent().append("<img src='/images/triangle_white.png' width='16' height='8' />");
  $("ul.subnav").parent().hoverIntent(hiConfig);
  $("ul.subnav").parent().children('a').replaceWith(function(link){
    return $(this).text();
  });
});