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
  
  $unassigned_members.droppable({
    accept: ":not(#unassigned_members li)",
    drop: function( event, ui ) {
      moveMember($(this), ui.draggable);
    }
  });
  
  $players.droppable({
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    accept: ":not(#players li)",
    drop: function( event, ui ) {
      moveMember($(this), ui.draggable);

      if (isFromUnassignedMembers(ui.draggable)) {
        createRole(ui.draggable.attr('id'), "player");
      }
      else {
        // update
      }
    }
  });
  
  function isFromUnassignedMembers($item) {
    return ($item.parent().attr('id') == $unassigned_members.attr('id'))
  }
  
  function moveMember($destination, $item) {
    $item.fadeOut(function() {
      $item.appendTo($destination).show();
    });
  }
  
  function createRole(id, role) {
    season_and_member_ids = id.split('-');
    
    $.ajax({url: "/admin/seasons/" + season_and_member_ids[0] + "/roles.js",
      data: { member_id: season_and_member_ids[1], role: role },
      type: 'POST',
      error: function (data) {
        alert('ERROR');
      }
    });
  }
});