var QAItemHandler;
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
QAItemHandler = (function() {
  function QAItemHandler(afterThisElement) {
    this.afterThisElement = afterThisElement;
    this.findFieldset();
    if (this.fieldset.length === 0) {
      this.addFieldsetHtml();
    }
    this.findOrderedList();
    if (this.orderedList.length === 0) {
      this.addOrderedListHtml();
    }
    this.countInputs();
    this.addButton();
  }
  QAItemHandler.prototype.findFieldset = function() {
    return this.fieldset = this.afterThisElement.next('fieldset.inputs');
  };
  QAItemHandler.prototype.findOrderedList = function() {
    return this.orderedList = this.fieldset.children().first();
  };
  QAItemHandler.prototype.addFieldsetHtml = function() {
    this.afterThisElement.after('<fieldset class="inputs"></fieldset>');
    return this.fieldset = this.afterThisElement.next();
  };
  QAItemHandler.prototype.addOrderedListHtml = function() {
    this.fieldset.append('<ol></ol>');
    return this.orderedList = this.fieldset.children().first();
  };
  QAItemHandler.prototype.addButton = function() {
    var addButton;
    this.fieldset.append('<button type="button">Moar</button>');
    addButton = this.fieldset.children().last();
    return addButton.click(__bind(function() {
      return this.addNewQuestion();
    }, this));
  };
  QAItemHandler.prototype.countInputs = function() {
    var foundInputs;
    foundInputs = this.orderedList.find('input');
    return this.questionNumber = foundInputs.length / 2;
  };
  QAItemHandler.prototype.addNewQuestion = function() {
    this.orderedList.append("<li class='string required' id='member_questions_attributes_" + this.questionNumber + "_content_input'><label for='member_questions_attributes_" + this.questionNumber + "_content'>Kysymys<abbr title='required'>*</abbr></label><input id='member_questions_attributes_" + this.questionNumber + "_content' maxlength='255' name='member[questions_attributes][" + this.questionNumber + "][content]' type='text' /></li>");
    this.orderedList.find(':input:').last().select();
    this.orderedList.append("<li class='string required' id='member_questions_attributes_" + this.questionNumber + "_answer_input'><label for='member_questions_attributes_" + this.questionNumber + "_answer'>Vastaus<abbr title='required'>*</abbr></label><input id='member_questions_attributes_" + this.questionNumber + "_answer' maxlength='255' name='member[questions_attributes][" + this.questionNumber + "][answer]' type='text' /></li>");
    return this.questionNumber++;
  };
  return QAItemHandler;
})();