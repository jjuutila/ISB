class DragDropManager
  constructor: (@options) -> 
    @defaults = $.extend(@defaults, @options)

  add_draggable_to_elements: ->
    console.log(@defaults)
    targe_elem = $(@defaults.draggable.target)
    $("li", targe_elem).draggable();    
    
  @defaults = {
    draggable: {
      target: null,
      appendTo: "body",
      helper: "clone",
      cursor: "move"
    },
    droppable: {
      target: null,
      accept: ":not(" + this.target + " li)",
      activeClass: "ui-state-default",
      hoverClass: "ui-state-hover"
    }
  }
  
  add_draggable_to_elements: ->
    console.log(@defaults)
    targe_elem = $(@defaults.draggable.target)
    $("li", targe_elem).draggable();

    
  
  