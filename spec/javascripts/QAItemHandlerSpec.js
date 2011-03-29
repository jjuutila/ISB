describe("QAItemHandler", function() {
  var moreButton;
  var container;
  var removeButton;
  
  describe('init', function() {
    it("adds a more button after #questions element", function() {
      loadFixtures('QAItemHandler/empty-container.html');
      qaHandler = new QAItemHandler($('#questions'), ['item'])
      qaHandler.init();
      
      expect($('#questions').next()).toBe(':button')
    })
    
    it("adds remove button to every existing question&answer fieldset", function() {
      loadFixtures('QAItemHandler/container-with-items.html');
      qaHandler = new QAItemHandler($('#questions'), ['item'])
      qaHandler.init();
      
      expect($('#questions').find('fieldset').first()).toContain('button.remove-question')
      expect($('#questions').find('fieldset').last()).toContain('button.remove-question')
    })
    
    it("adds remove button to every existing question&answer fieldset", function() {
      loadFixtures('QAItemHandler/container-with-items.html');
      qaHandler = new QAItemHandler($('#questions'), ['item'])
      qaHandler.init();
      expect(qaHandler.questionNumber).toBe(2);
    })
  })
  
  describe('more button click', function() {
    beforeEach(function() {
      $(document).ready(function() {
        loadFixtures('QAItemHandler/empty-container.html');
        container = $('#questions');
        qaHandler = new QAItemHandler(container, ['item'])
        qaHandler.init();
        
        moreButton = container.next(':button');
      });
    });
    
    it("triggers click event", function() {
      $(document).ready(function() {
        spyOnEvent(moreButton, 'click');
        moreButton.click();
        expect('click').toHaveBeenTriggeredOn(moreButton);
      });
    })
    
    it("creates fieldset", function() {
      moreButton.click();
      expect(container.children().first()).toBe('fieldset');
    })
    
    it("creates ordered list inside fieldset", function() {
      moreButton.click();
      expect(container.children().first().children().first()).toBe('ol');
    })
    
    it("creates list item with question input", function() {
      moreButton.click();
      ol = container.children().first().children().first();
      question = ol.find(':input').first();
      
      expect(question).toBe('input');
      expect(question.attr('id')).toBe('member_questions_attributes_0_content');
    })
    
    it("creates list item with answer input", function() {
      moreButton.click();
      ol = container.children().first().children().first();
      answer = ol.find(':input').last();
      
      expect(answer).toBe('input');
      expect(answer.attr('id')).toBe('member_questions_attributes_0_answer');
    })
    
    it("creates remove button inside fieldset", function() {
      moreButton.click();
      expect(container.children('fieldset').last()).toContain('button.remove-question')
    })
  })
  
  describe('delete button click', function() {
      beforeEach(function() {
      loadFixtures('QAItemHandler/container-with-items.html');
      
      qaHandler = new QAItemHandler($('#questions'), ['item'])
      qaHandler.init();
      
      removeButton = $('#questions').children('fieldset').find(':button').last()
    });
    
    it("removes fieldset where the clicked remove button is", function() {
      removeButton.click();
      expect($('#questions').children('fieldset').length).toBe(1)
    })
    
    it("adds hidden input if persistent question is deleted", function() {
      removeButton.click();
      expect($('#questions').children(':hidden').length).toBe(3)
      expect($('#questions').children(':hidden').last()).toHaveAttr('name', 'member[questions_attributes][1][_destroy]')
    })
    
    it("doesn't add hidden input if a non-persistent question is deleted", function() {
      qaHandler.addNewQuestion();
      removeButton = $('#questions').children('fieldset').find(':button').last()
      removeButton.click();
      expect($('#questions').children(':hidden').length).toBe(2);
    })
  })
});