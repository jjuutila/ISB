var Base, DragDropManager, DraggedElement;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
};
Base = (function() {
  function Base() {}
  Base.options = {};
  Base.fn = Base.prototype;
  Base.prototype.proxy = function(func) {
    var thisObject;
    thisObject = this;
    return function() {
      return func.apply(thisObject, arguments);
    };
  };
  return Base;
})();
DragDropManager = (function() {
  __extends(DragDropManager, Base);
  function DragDropManager() {
    this.options = {};
    this.defaults = {
      remote: {
        url: {
          base: "/",
          format: ".js"
        }
      },
      draggable: {
        appendTo: "body",
        helper: "clone",
        cursor: "move"
      },
      droppable: {
        accept: '.draggable-elements li',
        activeClass: "ui-state-default",
        hoverClass: "ui-state-hover"
      }
    };
  }
  DragDropManager.prototype.init = function(options) {
    $.extend(this.options, this.defaults, options);
    this.activateDraggableElements();
    return this.activateReceivingElements();
  };
  DragDropManager.prototype.parseNotAceptableElement = function(element) {
    var parsedSelector;
    return parsedSelector = ":not(." + element + " li)";
  };
  DragDropManager.prototype.moveableElements = function() {
    var target_elem;
    target_elem = "." + this.options.moveable_element + " li";
    if ($(target_elem)) {
      return $(target_elem);
    } else {
      return nul;
    }
  };
  DragDropManager.prototype.receivingElement = function() {
    var target_elem;
    target_elem = "." + this.options.receiving_element;
    if ($(target_elem)) {
      return $(target_elem);
    } else {
      return nul;
    }
  };
  DragDropManager.prototype.activateDraggableElements = function() {
    if (this.moveableElements().length > 0) {
      return (this.moveableElements()).draggable(this.options.draggable);
    }
  };
  DragDropManager.prototype.activateReceivingElements = function() {
    var allOptions, eventHandlers;
    if (this.receivingElement().length > 0) {
      allOptions = {};
      eventHandlers = {
        drop: this.proxy(function() {
          return this.elementDropped(arguments);
        })
      };
      allOptions = $.extend(this.options.droppable, eventHandlers);
      return this.receivingElement().droppable(allOptions);
    }
  };
  DragDropManager.prototype.elementDropped = function(arguments) {
    var draggedElement;
    if (arguments == null) {
      arguments = null;
    }
    if (this.isDropAllowed(arguments)) {
      draggedElement = new DraggedElement(arguments, this.options.remote);
      return draggedElement.doRemoteCall();
    }
  };
  DragDropManager.prototype.isDropAllowed = function(args) {
    return $(args[0].target).attr('id') !== $(args[1].helper.prevObject.parent()).attr('id');
  };
  return DragDropManager;
})();
DraggedElement = (function() {
  __extends(DraggedElement, Base);
  function DraggedElement(args, options) {
    this.options = {};
    this.newHostElement = this.getNewHostElement(args);
    this.previousHostElement = this.getPreviousHostElement(args);
    this.referenceToSelf = this.getDraggedElement(args);
    this.idToUrl = "";
    $.extend(this.options, options);
  }
  DraggedElement.prototype.getNewHostElement = function(args) {
    return $(args[0].target);
  };
  DraggedElement.prototype.getPreviousHostElement = function(args) {
    return $(args[1].helper.prevObject.parent());
  };
  DraggedElement.prototype.getDraggedElement = function(args) {
    return $(args[1].draggable);
  };
  DraggedElement.prototype.doRemoteCall = function() {
    if (this.needDestroy()) {
      return this.destroy();
    } else if (this.needUpdate()) {
      return this.update();
    } else {
      return this.create();
    }
  };
  DraggedElement.prototype.needUpdate = function() {
    return (this.previousHostElement.attr("id").split("-"))[1].length > 0;
  };
  DraggedElement.prototype.needDestroy = function() {
    return this.getHostId() === null;
  };
  DraggedElement.prototype.destroy = function() {
    this.requestMethod = 'DELETE';
    this.idToUrl = "/" + this.getId();
    return this.makeRequest();
  };
  DraggedElement.prototype.update = function() {
    this.requestMethod = 'PUT';
    this.idToUrl = "/" + this.getId();
    return this.makeRequest();
  };
  DraggedElement.prototype.create = function() {
    this.requestMethod = 'POST';
    return this.makeRequest();
  };
  DraggedElement.prototype.getId = function() {
    if ((this.referenceToSelf.attr("id").split("-")).length === 2) {
      return this.referenceToSelf.attr("id").split("-")[1];
    } else {
      return null;
    }
  };
  DraggedElement.prototype.makeRequest = function() {
    return $.ajax({
      url: this.buildUrl(),
      data: this.buildRequestData(),
      type: this.convertToPostIfDeleteOrPut(this.requestMethod),
      beforeSend: this.proxy(function() {
        return this.overwriteRequestHeader(arguments);
      }),
      error: this.proxy(function() {
        return this.failuredRequest();
      }),
      success: this.proxy(function() {
        return this.successFullRequest(arguments);
      })
    });
  };
  DraggedElement.prototype.buildUrl = function() {
    return this.options.url.base + this.idToUrl + this.options.url.format;
  };
  DraggedElement.prototype.buildRequestData = function() {
    var data, modelData;
    modelData = {};
    modelData[this.getHostType().toString()] = this.getHostId();
    data = {};
    data[this.getType().toString()] = this.getId();
    data["data"] = modelData;
    return data;
  };
  DraggedElement.prototype.convertToPostIfDeleteOrPut = function(method) {
    method = method.toUpperCase();
    if (method === 'DELETE' || method === 'PUT') {
      return 'POST';
    } else {
      return method;
    }
  };
  DraggedElement.prototype.getHostType = function() {
    if ((this.newHostElement.attr("id").split("-")).length === 2) {
      return (this.newHostElement.attr("id")).split("-")[0];
    } else {
      return null;
    }
  };
  DraggedElement.prototype.getHostId = function() {
    var splittedId;
    splittedId = this.newHostElement.attr("id").split("-");
    if (splittedId.length > 1 && splittedId[1]) {
      return splittedId[1];
    } else {
      return null;
    }
  };
  DraggedElement.prototype.getType = function() {
    if ((this.referenceToSelf.attr("id").split("-")).length === 2) {
      return this.referenceToSelf.attr("id").split("-")[0];
    } else {
      return null;
    }
  };
  DraggedElement.prototype.overwriteRequestHeader = function(arguments) {
    var xhr;
    xhr = arguments[0];
    return xhr.setRequestHeader("X-Http-Method-Override", this.requestMethod);
  };
  DraggedElement.prototype.successFullRequest = function(args) {
    return this.moveItem(this.newHostElement, this.referenceToSelf);
  };
  DraggedElement.prototype.failuredRequest = function() {
    return alert('Pelaajan siirtäminen epäonnistui.');
  };
  DraggedElement.prototype.hide = function(element) {
    return elememnt.hide();
  };
  DraggedElement.prototype.moveItem = function(to, element) {
    return element.fadeOut(function() {
      return element.appendTo(to).show();
    });
  };
  return DraggedElement;
})();