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
});
