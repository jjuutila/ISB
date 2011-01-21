(function() {
  var DragDropManager;
  DragDropManager = (function() {
    function DragDropManager(options) {
      this.options = options;
      this.defaults = $.extend(this.defaults, this.options);
    }
    DragDropManager.prototype.add_draggable_to_elements = function() {
      var targe_elem;
      console.log(this.defaults);
      targe_elem = $(this.defaults.draggable.target);
      return $("li", targe_elem).draggable();
    };
    DragDropManager.defaults = {
      draggable: {
        target: null,
        appendTo: "body",
        helper: "clone",
        cursor: "move"
      },
      droppable: {
        target: null,
        accept: ":not(" + DragDropManager.target + " li)",
        activeClass: "ui-state-default",
        hoverClass: "ui-state-hover"
      }
    };
    DragDropManager.prototype.add_draggable_to_elements = function() {
      var targe_elem;
      console.log(this.defaults);
      targe_elem = $(this.defaults.draggable.target);
      return $("li", targe_elem).draggable();
    };
    return DragDropManager;
  })();
}).call(this);
