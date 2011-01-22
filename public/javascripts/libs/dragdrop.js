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
    return ":not(#" + element + " li)";
  };
  DragDropManager.prototype.moveableElements = function() {
    var target_elem;
    target_elem = "." + this.options.moveable_element + " li";
    return $(target_elem);
  };
  DragDropManager.prototype.receivingElement = function() {
    var target_elem;
    target_elem = "." + this.options.receiving_element;
    return $(target_elem);
  };
  DragDropManager.prototype.activateDraggableElements = function() {
    return (this.moveableElements()).draggable(this.options.draggable);
  };
  DragDropManager.prototype.activateReceivingElements = function() {
    var allOptions, eventHandlers;
    allOptions = {};
    eventHandlers = {
      drop: this.proxy(function() {
        return this.elementDropped(arguments);
      })
    };
    allOptions = $.extend(this.options.droppable, eventHandlers);
    return this.receivingElement().droppable(allOptions);
  };
  DragDropManager.prototype.elementDropped = function(arguments) {
    var draggedElement;
    if (arguments == null) {
      arguments = null;
    }
    draggedElement = new DraggedElement(arguments, this.options.remote);
    return draggedElement.persistent();
  };
  DragDropManager.prototype.isAllowedToLand = function(dropped, place) {
    return dropped.id !== place.id;
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
  DraggedElement.prototype.persistent = function() {
    console.log("sfdfds");
    if (this.needUpate()) {
      return console.log("Need update");
    } else {
      return this.create();
    }
  };
  DraggedElement.prototype.create = function() {
    console.log;
    return this.makeRequest();
  };
  DraggedElement.prototype.needUpate = function() {
    return (this.previousHostElement.attr("id").split("-"))[1].length > 0;
  };
  DraggedElement.prototype.getId = function() {
    if ((this.referenceToSelf.attr("id").split("-")).length === 2) {
      return this.referenceToSelf.attr("id").split("-")[1];
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
  DraggedElement.prototype.getHostType = function() {
    if ((this.newHostElement.attr("id").split("-")).length === 2) {
      return (this.newHostElement.attr("id")).split("-")[0];
    } else {
      return null;
    }
  };
  DraggedElement.prototype.getHostId = function() {
    if ((this.newHostElement.attr("id").split("-")).length === 2) {
      return (this.newHostElement.attr("id")).split("-")[1];
    } else {
      return null;
    }
  };
  DraggedElement.prototype.buildUrl = function() {
    console.log(this.options);
    return this.options.url.base + this.options.url.format;
  };
  DraggedElement.prototype.buildRequestData = function() {
    var data;
    data = {};
    data[this.getHostType().toString()] = this.getHostId();
    data[this.getType().toString()] = this.getId();
    return data;
  };
  DraggedElement.prototype.makeRequest = function() {
    return $.ajax({
      url: this.buildUrl(),
      data: this.buildRequestData(),
      type: 'POST',
      error: this.proxy(function() {
        return this.failuredRequet(arguments);
      }),
      success: this.proxy(function() {
        return this.successFullRequest(arguments);
      })
    });
  };
  DraggedElement.prototype.successFullRequest = function(args) {
    return this.moveItem(this.newHostElement, this.referenceToSelf);
  };
  DraggedElement.prototype.failuredRequet = function(args) {
    console.log("Failure: ");
    return console.log(args);
  };
  DraggedElement.prototype.hide = function(element) {
    return elememnt.hide();
  };
  DraggedElement.prototype.moveItem = function(to, element) {
    return element.fadeOut(function() {
      console.log(to, element);
      return element.appendTo(to).show();
    });
  };
  return DraggedElement;
})();