describe("DragDropManager", function() {
  var ddManager;
  var ajaxData = 'some ajax data';
  var fixtureUrl = 'some_url';
  var anotherFixtureUrl = 'another_url';
  var fixturesContainer = function() {
    return $('#' + jasmine.getFixtures().containerId);
  };
  var appendFixturesContainerToDom = function() {
    $('body').append('<div id="' + jasmine.getFixtures().containerId + '">old content</div>');
  };

  beforeEach(function() {
    jasmine.getFixtures().clearCache();
    spyOn($, 'ajax').andCallFake(function(options) {
      options.success(ajaxData);
    });
    
    ddManager = new DragDropManager();
    ddManager.init({moveable_element: 'draggable-elements', 
                  receiving_element: 'drop-place',
                  remote: { url: {base: "/admin/seasons/1", format: "/roles.js"}}
                  });   
    
  });
  
  it("should parse jquery valid selector", function() {
    var element = "not-allowed";
    expect(ddManager.parseNotAceptableElement(element)).toEqual(":not(." + element + " li)");
  });  
  
  it("should find all element which are set to be draggable", function() {
    loadFixtures('drag-and-drop-manager.html');
    ddManager
    
  })
  
  
});