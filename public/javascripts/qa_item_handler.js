var QAItemHandler;
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
QAItemHandler = (function() {
  function QAItemHandler(container) {
    this.container = container;
    this.questionNumber = 0;
  }
  QAItemHandler.prototype.init = function() {
    this.addMoreButton();
    return this.addRemoveButtons();
  };
  QAItemHandler.prototype.addOrderedListHtml = function() {
    this.fieldset.append('<ol></ol>');
    return this.orderedList = this.fieldset.children().first();
  };
  QAItemHandler.prototype.addMoreButton = function() {
    var addButton;
    addButton = $('<button type="button" class="new-question"><img alt="Add" src="/images/add.png" /> Uusi kysymys</button>');
    this.container.after(addButton);
    return addButton.click(__bind(function() {
      return this.addNewQuestion();
    }, this));
  };
  QAItemHandler.prototype.addRemoveButtons = function() {
    return this.container.children('fieldset').each(__bind(function(index, fieldset) {
      $(fieldset).append(this.createRemoveButton());
      return this.questionNumber++;
    }, this));
  };
  QAItemHandler.prototype.createRemoveButton = function() {
    var removeButton;
    removeButton = $('<button type="button" class="remove-question"><img alt="cross" src="/images/cross.png" /></button>');
    removeButton.bind('click', {
      questionIndex: this.questionNumber
    }, __bind(function(event) {
      return this.removeQuestion(event);
    }, this));
    return removeButton;
  };
  QAItemHandler.prototype.removeQuestion = function(event) {
    this.markForDestruction(event.data.questionIndex);
    return $(event.target).parent().remove();
  };
  QAItemHandler.prototype.markForDestruction = function(index) {
    var hiddenInput, idInput;
    idInput = this.container.children("#member_questions_attributes_" + index + "_id");
    if (idInput.length === 1) {
      hiddenInput = $("<input id='member_questions_attributes_" + index + "_destroy' name='member[questions_attributes][" + index + "][_destroy]' type='hidden' value='1' />");
      return this.container.append(hiddenInput);
    }
  };
  QAItemHandler.prototype.addNewQuestion = function() {
    var fieldset, orderedList;
    fieldset = $('<fieldset class="inputs"></fieldset>');
    this.container.append(fieldset);
    orderedList = $('<ol></ol>');
    fieldset.append(orderedList);
    orderedList.append("<li class='string required inline-input' id='member_questions_attributes_" + this.questionNumber + "_content_input'><label for='member_questions_attributes_" + this.questionNumber + "_content'>Kysymys<abbr title='required'>*</abbr></label><input id='member_questions_attributes_" + this.questionNumber + "_content' maxlength='255' name='member[questions_attributes][" + this.questionNumber + "][content]' type='text' /></li>");
    orderedList.find(':input:').last().select();
    orderedList.append("<li class='string required inline-input' id='member_questions_attributes_" + this.questionNumber + "_answer_input'><label for='member_questions_attributes_" + this.questionNumber + "_answer'>Vastaus<abbr title='required'>*</abbr></label><input id='member_questions_attributes_" + this.questionNumber + "_answer' maxlength='255' name='member[questions_attributes][" + this.questionNumber + "][answer]' type='text' /></li>");
    fieldset.append(this.createRemoveButton());
    return this.questionNumber++;
  };
  return QAItemHandler;
})();