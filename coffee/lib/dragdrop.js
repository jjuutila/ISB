var DragDropManager;
DragDropManager = (function() {
  function DragDropManager() {
    this.defaults = {
      draggable: {
        appendTo: "body",
        helper: "clone",
        cursor: "move"
      },
      droppable: {
        accept: 'drop-place',
        activeClass: "ui-state-default",
        hoverClass: "ui-state-hover"
      }
    };
  }
  DragDropManager.previousParents = {};
  DragDropManager.options = {};
  DragDropManager.prototype.init = function(options) {
    this.options = $.extend(this.defaults, options);
    this.activateDraggableElements();
    return this.activeteDroppableElements();
  };
  DragDropManager.prototype.parseNotAceptableElement = function(element) {
    return ":not(#" + element + " li)";
  };
  DragDropManager.prototype.getOptions = function() {
    return this.options;
  };
  DragDropManager.prototype.moveableElements = function() {
    var targe_elem;
    targe_elem = "." + this.options.moveable_element + " li";
    return $(targe_elem);
  };
  DragDropManager.prototype.activateDraggableElements = function() {
    return (this.moveableElements()).draggable(this.options.draggable);
  };
  DragDropManager.prototype.activeteDroppableElements = function() {
    return this.moveableElements().droppable({
      drop: function(event, ui) {
        return this.elementDropped(event, ui);
      }
    });
  };
  DragDropManager.prototype.moveItem = function(from, element) {
    return element.fadeOut(function() {
      return element.appendTo(to).show();
    });
  };
  DragDropManager.prototype.elementDropped = function(event, ui) {
    return console.log(ui);
  };
  DragDropManager.prototype.isAllowedToLand = function(dropped, place) {
    return dropped.id !== place.id;
  };
  return DragDropManager;
})();