describe("monitorStandings", function() {
  var tbody;
  
  beforeEach(function() {
    loadFixtures('MonitorStandings/three-rows.html');
    tbody = $('tbody');
    tbody.monitorStandings();
  });
  
  describe('input change', function() {
    beforeEach(function() {
      wins = $('#standings_199_wins');
      wins.val(16);
      wins.trigger('textchange');
    });
    
    it("updates points of changed row", function() {
      pointsElement = wins.parents('tr').find('.points-cell');
      expect(pointsElement.text()).toEqual('35');
    });
    
    it("updates games played of changed row", function() {
      gamesPlayedElement = wins.parents('tr').find('.games-played-cell');
      expect(gamesPlayedElement.text()).toEqual('23');
    });
  })
});
