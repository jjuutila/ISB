$(document).ready(function(){  
  hiConfig = {
    sensitivity: 2,
    interval: 200, 
    timeout: 300,
    over: function() {
      $(this).addClass("subhover");
      $(this).find("img").attr('src', '/images/triangle_grey.png');
      $(this).find("ul.subnav").slideDown('fast').show(); //Drop down the subnav on click
    },
    out: function() {
      $(this).find("ul.subnav").slideUp('slow');
      $(this).find("img").attr('src', '/images/triangle_white.png');
      $(this).removeClass("subhover");
      
    }
  }
  
  $('ul.topnav li').hoverIntent(hiConfig)

  $("ul.subnav").parent().append("<img src='/images/triangle_white.png' style='margin-top:16px'>");
});
