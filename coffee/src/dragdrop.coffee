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
    parsedSelector = ":not(."+element+" li)"
  
  moveableElements: ->
    target_elem = "." + @options.moveable_element + " li"
    if $(target_elem)
      $(target_elem)
    else
      nul

  receivingElement: ->
    target_elem = "." + @options.receiving_element
    if $(target_elem)
      $(target_elem)
    else
      nul

  activateDraggableElements: () ->
    if (@moveableElements().length > 0)
      (@moveableElements()).draggable(@options.draggable)
    
  activateReceivingElements: () ->
    if (@receivingElement().length > 0)
      allOptions = {}
      eventHandlers = { 
        drop: @proxy ->
          @elementDropped(arguments) }
        allOptions = $.extend(@options.droppable, eventHandlers)
      @receivingElement().droppable(allOptions)
   
  elementDropped:(arguments=null) ->
    if (@isDropAllowed(arguments))
      draggedElement = new DraggedElement(arguments, @options.remote)
      draggedElement.doRemoteCall()
 
  isDropAllowed:(args) ->
    $(args[0].target).attr('id') != $(args[1].helper.prevObject.parent()).attr('id')

class DraggedElement extends Base
  constructor: (args, options) ->  
    @options = {}
    @newHostElement = @getNewHostElement(args)
    @previousHostElement = @getPreviousHostElement(args)
    @referenceToSelf = @getDraggedElement(args)
    @idToUrl = ""
    $.extend(@options, options)
    
  getNewHostElement:(args) ->
    $(args[0].target)

  getPreviousHostElement:(args) ->
    $(args[1].helper.prevObject.parent())

  getDraggedElement:(args) ->
    $(args[1].draggable)    
    
  doRemoteCall:() ->
    if(@needDestroy())
      @destroy()
    else if(@needUpdate())
      @update()
    else
      @create()
    
  needUpdate:() ->
    (@previousHostElement.attr("id").split("-"))[1].length > 0

  needDestroy:() ->
    @getHostId() is null

  destroy:() ->
    console.log("destroy")
    @requestMethod = 'DELETE'
    @idToUrl = "/" + @getId()
    @makeRequest()
    
  update:() ->
    console.log("update")
    @requestMethod = 'PUT'
    @idToUrl = "/" + @getId()
    @makeRequest()

  create:() ->
    console.log
    @requestMethod = 'POST'
    @makeRequest()
    
  getId:() ->
    if ((@referenceToSelf.attr("id").split("-")).length == 2)
      @referenceToSelf.attr("id").split("-")[1]
    else
      null
  
  makeRequest:() ->
    type = @requestMethod

    if (@requestMethod.toUpperCase() is 'GET')
      type = 'GET'

    $.ajax({
      url: @buildUrl(),
      data: @buildRequestData(),
      type: type,
      beforeSend: @proxy ->
        @overwriteRequestHeader(arguments)

      error: @proxy -> 
        @failuredRequet(arguments)
      
      success: @proxy ->
        @successFullRequest(arguments)
    });
  
  buildUrl:() ->
    console.log @options
    @options.url.base + @idToUrl + @options.url.format
  
  buildRequestData:() ->
    modelData = {}
    modelData[@getHostType().toString()] = @getHostId()

    data = {}
    data[@getType().toString()] = @getId()
    data["data"] = modelData
    data

  getHostType:() ->
    if((@newHostElement.attr("id").split("-")).length == 2)
      (@newHostElement.attr("id")).split("-")[0]
    else
      null
      
  getHostId:() ->
    splittedId = @newHostElement.attr("id").split("-")
    if(splittedId.length > 1 and splittedId[1])
      splittedId[1]
    else
      null
  
  getType:() ->
    if ((@referenceToSelf.attr("id").split("-")).length == 2)
      @referenceToSelf.attr("id").split("-")[0]
    else
      null

  overwriteRequestHeader:(arguments) ->
    xhr = arguments[0]
    xhr.setRequestHeader("X-Http-Method-Override", @requestMethod);

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
