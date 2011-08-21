describe("rankSponsors", function() {
  var content;
  var sortButton;
  var cancelButton;
  
  beforeEach(function() {
    loadFixtures('SortSponsors/sponsor-list.html');
    content = $('section#content');
    sortButton = $('button#sort-sponsors');
    
    content.sortSponsors();
  });
  
  describe('when not sorting', function() {
    describe('sort button click', function() {
      beforeEach(function() {
  
      });
      
      it("triggers click event", function() {
        $(document).ready(function() {
          spyOnEvent(sortButton, 'click');
          sortButton.click();
          expect('click').toHaveBeenTriggeredOn(sortButton);
        });
      });
      
      it("sets the sort button text", function() {
        sortButton.click();
        expect(sortButton.text()).toEqual('Tallenna');
      });
      
      it("adds cancel button", function() {
        sortButton.click();
        expect($('button#cancel-sorting')).toExist();
      });
      
      it("adds edit mode style to table body", function() {
        sortButton.click();
        expect(content.find('tbody').first()).toHaveClass('sortable-sponsors');
      });
      
      it("hides sponsor actions", function() {
        sortButton.click();
        expect($('.sponsor-actions')).not.toBeVisible();
      });
    });
  });
  
  describe('when sorting', function() {
    beforeEach(function() {
      // Set to sorting mode
      sortButton.click();
    });
    
    describe('cancel button click', function() {
      beforeEach(function() {
        cancelButton = $('button#cancel-sorting');
        changeSponsorOrder();
      });
      
      it("removes the cancel button", function() {
        cancelButton.click();
        expect(content.find('button#cancel-sorting')).not.toExist();
      });
      
      it("reverts changes made to sponsor ordering", function() {
        cancelButton.click();
        rows = content.find('tbody').find('tr');
        expect(rows.first()).toHaveId('sponsor-1');
        expect(rows.eq(1)).toHaveId('sponsor-2');
      });
      
      it("changes the sort button text", function() {
        cancelButton.click();
        expect(sortButton.text()).toEqual('Muokkaa järjestystä');
      });
      
      it("is no longer sortable", function(){
        cancelButton.click();
        expect($("tbody").sortable( "option", "disabled" )).toBeTruthy();
      });
      
      it("shows sponsor actions again", function(){
        cancelButton.click();
        expect($('.sponsor-actions')).toBeVisible();
      });
    });
    
    describe('save button click', function() {
      beforeEach(function() {
        spyOn($, "ajax");
      });
      
      it("sends a PUT request to URL 'order.js'", function() {
        // Sort button behavior is changed to a save button
        sortButton.click();
        var request = $.ajax.mostRecentCall;
        expect(request.args[0]["url"]).toEqual("sponsors/positions.js");
        expect(request.args[0]['type']).toEqual('PUT');
      });
      
      it("sends an AJAX request containing sponsor IDs", function() {
        changeSponsorOrder();
        sortButton.click();
        expect($.ajax.mostRecentCall.args[0]["data"]).toEqual({positions: [2, 1]});
      });
      
      it("is no longer sortable", function(){
        sortButton.click();
        expect($("tbody").sortable( "option", "disabled" )).toBeTruthy();
      });
      
      it("does not look like in sort mode", function() {
        sortButton.click();
        expect(content.find('tbody').first()).not.toHaveClass('sortable-sponsors');
      });
      
      it("removes the cancel button", function() {
        sortButton.click();
        expect($('button#cancel-sorting')).not.toExist();
      });
      
      it("changes the sort button text", function() {
        sortButton.click();
        expect(sortButton.text()).toEqual('Muokkaa järjestystä');
      });
    });
  });
  
  
  describe('sort button click after cancel', function() {
    it("does not send an AJAX request", function(){
      sortButton.click();
      $('button#cancel-sorting').click();
      spyOn($, "ajax")
      sortButton.click();
      expect($.ajax).not.toHaveBeenCalled();
    });
    
    it("is sortable again", function(){
        sortButton.click();
        expect($("tbody").sortable( "option", "disabled" )).toBeFalsy();
      });
  });
  
  function changeSponsorOrder() {
    sponsor1 = $('#sponsor-1');
    sponsor1.detach();
    sponsor1.insertAfter($('#sponsor-2'));
  };
});
