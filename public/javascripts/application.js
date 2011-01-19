// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  var $players = $('#players');
  var $unassigned_members = $('#unassigned_members');
  
  $("li", $unassigned_members).draggable({
    appendTo: "body",
    helper: "clone",
    cursor: "move"
  });
  
  $("li", $players).draggable({
    appendTo: "body",
    helper: "clone",
    cursor: "move"
  });
  
  $("ul", $unassigned_members).droppable({
    accept: ":not(#unassigned_members li)",
    drop: function( event, ui ) {
      moveMember($(this), ui.draggable);
    }
  });
  
  $("ul", $players).droppable({
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    accept: ":not(#players li)",
    drop: function( event, ui ) {
      moveMember($(this), ui.draggable);
      updateRole($(this).attr('id'), ui.draggable.attr('id'), "player");
    }
  });
  
  function isAcceptable(item) {
    
  }
  
  function moveMember($destination, $item) {
    $item.fadeOut(function() {
      //var $destination_list = $("ul", $players).length ? $("ul", $players) : $("ul", $unassigned_members).appendTo($players);
      $item.appendTo($destination).show();
    });
  }
  
  function updateRole(seasonID, playerID, role) {
    $.post("/admin/seasons/" + seasonID + "/roles/" + playerID + "/set_role", {role: role});
  }

});