var $;
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
$ = jQuery;
$.fn.extend({
  sortSponsors: function() {
    var self;
    self = $.fn.sortSponsors;
    return self.init();
  }
});
$.extend($.fn.sortSponsors, {
  init: function() {
    this.sortButton = $('button#sort-sponsors');
    this.actionsContainer = $('#sort-actions');
    $('tbody').sortable({
      disabled: true,
      cursor: 'move'
    });
    return this.setAsSortButton();
  },
  setAsSortButton: function() {
    this.sortButton.text('Muokkaa järjestystä');
    return this.sortButton.bind('click', __bind(function(event) {
      return this.beginSorting();
    }, this));
  },
  beginSorting: function() {
    this.saveOriginalSponsorList();
    this.addCancelButton();
    this.setSortButtonAsSave();
    return this.setAsSortable();
  },
  saveOriginalSponsorList: function() {
    return this.originalSponsorList = $('tbody').find('tr');
  },
  addCancelButton: function() {
    this.cancelButton = $('<button id="cancel-sorting" type="button">Peruuta</button>');
    this.actionsContainer.append(this.cancelButton);
    return this.cancelButton.bind('click', __bind(function(event) {
      return this.cancelSorting();
    }, this));
  },
  setAsSortable: function() {
    $('tbody').sortable("option", "disabled", false);
    $('tbody').addClass('sortable-sponsors');
    return $('.sponsor-actions').hide();
  },
  setAsNotSortable: function() {
    $('tbody').sortable("option", "disabled", true);
    $('tbody').removeClass('sortable-sponsors');
    return $('.sponsor-actions').show();
  },
  setSortButtonAsSave: function() {
    this.sortButton.unbind('click');
    this.sortButton.text('Tallenna');
    return this.sortButton.bind('click', __bind(function(event) {
      return this.savePositions();
    }, this));
  },
  savePositions: function() {
    var positions;
    this.setAsSortButton();
    this.setAsNotSortable();
    this.cancelButton.remove();
    positions = this.getPositions();
    return $.ajax({
      url: "sponsors/positions.js",
      data: {
        positions: positions
      },
      type: 'PUT'
    });
  },
  getPositions: function() {
    var positions;
    positions = [];
    $('tbody').find('tr').each(function(index, tr) {
      var id;
      id = parseInt($(tr).attr('id').split('-')[1]);
      return positions.push(id);
    });
    return positions;
  },
  cancelSorting: function() {
    this.cancelButton.remove();
    $('tbody').html(this.originalSponsorList);
    this.sortButton.unbind('click');
    this.setAsSortButton();
    return this.setAsNotSortable();
  }
});