class Base
  @options = {}
  @fn = @prototype;  
  
  proxy: (func)->
    thisObject = this
    () ->
      func.apply(thisObject, arguments)

class DragDropManager extends Base
  constructor: () ->
    @options = {}
    @defaults = { 
      remote:    { url: {base: "/", format: ".js"} },
      draggable: { appendTo: "body", helper: "clone", cursor: "move"},
      droppable: { accept: '.draggable-elements li', activeClass: "ui-state-default", hoverClass: "ui-state-hover"}}
  
  init: (options) ->
    $.extend(@options, @defaults, options)
    @activateDraggableElements()
    @activateReceivingElements()

  parseNotAceptableElement: (element) ->
    ":not(#" + element + " li)"
  
  moveableElements: ->
    target_elem = "." + @options.moveable_element + " li"
    $(target_elem)

  receivingElement: ->
    target_elem = "." + @options.receiving_element
    $(target_elem)

  activateDraggableElements: () ->
    (@moveableElements()).draggable(@options.draggable)
    
  activateReceivingElements: () ->
    allOptions = {}
    eventHandlers = { 
      drop: @proxy ->
        @elementDropped(arguments) }
    allOptions = $.extend(@options.droppable, eventHandlers)
    @receivingElement().droppable(allOptions)
   
  elementDropped:(arguments=null) ->
    draggedElement = new DraggedElement(arguments, @options.remote)
    draggedElement.persistent()
 
  isAllowedToLand:(dropped, place) ->
    dropped.id != place.id
      

class DraggedElement extends Base
  constructor: (args, options) ->  
    @options = {}
    @newHostElement = @getNewHostElement(args)
    @previousHostElement = @getPreviousHostElement(args)
    @referenceToSelf = @getDraggedElement(args)
    $.extend(@options, options)
    
  getNewHostElement:(args) ->
    $(args[0].target)

  getPreviousHostElement:(args) ->
    $(args[1].helper.prevObject.parent())

  getDraggedElement:(args) ->
    $(args[1].draggable)    
    
  persistent:() ->
    console.log "sfdfds"
    if(@needUpate())
      console.log "Need update"
    else
      @create()
    
  create:() ->
    console.log 
    @makeRequest()
    
  needUpate:() ->
    (@previousHostElement.attr("id").split("-"))[1].length > 0
    
  getId:() ->
    if ((@referenceToSelf.attr("id").split("-")).length == 2)
      @referenceToSelf.attr("id").split("-")[1]
    else
      null
  
  getType:() ->
    if ((@referenceToSelf.attr("id").split("-")).length == 2)
      @referenceToSelf.attr("id").split("-")[0]
    else
      null    

  getHostType:() ->
    if((@newHostElement.attr("id").split("-")).length == 2)
      (@newHostElement.attr("id")).split("-")[0]
    else
      null
      
  getHostId:() ->
    if((@newHostElement.attr("id").split("-")).length == 2)
      (@newHostElement.attr("id")).split("-")[1]
    else
      null    
      
  buildUrl:() ->
    console.log @options
    @options.url.base + @options.url.format 
  
  buildRequestData:() ->
    data = {}
    data[@getHostType().toString()] = @getHostId()
    data[@getType().toString()] = @getId()
    data
  
  makeRequest:() ->
    $.ajax({
      url: @buildUrl(),
      data: @buildRequestData(),
      type: 'POST',
      error: @proxy -> 
        @failuredRequet(arguments)
      
      success: @proxy ->
        @successFullRequest(arguments)
    });  
  
  successFullRequest:(args) ->
    @moveItem(@newHostElement, @referenceToSelf)   
  
  failuredRequet: (args) ->
    console.log "Failure: "
    console.log args      
        
  hide:(element) ->
    elememnt.hide()
    
  moveItem:(to, element) ->
    element.fadeOut ->
      console.log to, element
      element.appendTo(to).show()
    
    
  


