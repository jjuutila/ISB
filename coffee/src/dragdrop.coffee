class DragDropManager
  constructor: () ->
    @defaults = { 
      draggable: { appendTo: "body", helper: "clone", cursor: "move"},
      droppable: { accept: 'drop-place', activeClass: "ui-state-default", hoverClass: "ui-state-hover"}}
  
  @previousParents = {}
  @options = {}
  
  init: (options) ->
    @options = $.extend(@defaults, options)
    @activateDraggableElements()
    @activeteDroppableElements()

  parseNotAceptableElement: (element) ->
    ":not(#" + element + " li)"
  
  getOptions: ->
    @options

  moveableElements: ->
    targe_elem = "." + @options.moveable_element + " li"
    $(targe_elem)

  activateDraggableElements: () ->
    (@moveableElements()).draggable(@options.draggable)
    
  activeteDroppableElements: () ->
    @moveableElements().droppable({
      drop: (event, ui) ->
        @elementDropped(event, ui)
    })
    
  moveItem:(from, element) ->
    element.fadeOut ->
      element.appendTo(to).show()
 
  elementDropped:(event, ui) ->
    console.log ui
 
  isAllowedToLand:(dropped, place) ->
    dropped.id != place.id
  



