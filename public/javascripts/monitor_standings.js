var $;
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
$ = jQuery;
$.fn.extend({
  monitorStandings: function() {
    var self;
    self = $.fn.monitorStandings;
    $(this).find('input').numeric();
    $(this).sortable({
      cursor: 'move'
    });
    return $(this).find('input').bind('textchange', __bind(function(event) {
      self.updateValues(event.currentTarget);
      if ($('#auto_sort_standings').is(':checked')) {
        return $(this).find('tr').sortElements(function(a, b) {
          return self.compare(a, b);
        });
      }
    }, this));
  }
});
$.extend($.fn.monitorStandings, {
  updateValues: function(target) {
    var row;
    row = $(target).parents('tr');
    this.updatePoints(row);
    return this.updateGamesPlayed(row);
  },
  updatePoints: function(row) {
    var points, pointsElement;
    points = this.calculatePoints(row.find('input'));
    pointsElement = row.find('.points-cell');
    return pointsElement.text(points);
  },
  calculatePoints: function(inputs) {
    return 2 * parseInt(inputs[0].value) + parseInt(inputs[1].value);
  },
  updateGamesPlayed: function(row) {
    var gamesPlayed, gamesPlayedElement;
    gamesPlayed = this.calculateGamesPlayed(row.find('input'));
    gamesPlayedElement = row.find('.games-played-cell');
    return gamesPlayedElement.text(gamesPlayed);
  },
  calculateGamesPlayed: function(inputs) {
    return parseInt(inputs[0].value) + parseInt(inputs[1].value) + parseInt(inputs[2].value);
  },
  compare: function(a, b) {
    var pointDifference;
    pointDifference = this.calculatePointDifference(a, b);
    if (pointDifference !== 0) {
      return pointDifference;
    } else {
      return this.calculateGoalsDifference(a, b);
    }
  },
  calculatePointDifference: function(a, b) {
    var pointsA, pointsB;
    pointsA = parseInt($(a).find('.points-cell').text());
    pointsB = parseInt($(b).find('.points-cell').text());
    return pointsB - pointsA;
  },
  calculateGoalsDifference: function(a, b) {
    var aGoalRatio, aInputs, bGoalRatio, bInputs;
    aInputs = $(a).find('input');
    aGoalRatio = parseInt(aInputs[3].value) - parseInt(aInputs[4].value);
    bInputs = $(b).find('input');
    bGoalRatio = parseInt(bInputs[3].value) - parseInt(bInputs[4].value);
    if (aGoalRatio > bGoalRatio) {
      return -1;
    }
    if (bGoalRatio > aGoalRatio) {
      return +1;
    } else {
      return 0;
    }
  }
});