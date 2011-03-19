class QAItemHandler
  constructor: (@afterThisElement) ->
    @findFieldset()
    if @fieldset.length == 0
      @addFieldsetHtml()

    @findOrderedList()
    if @orderedList.length == 0
      @addOrderedListHtml()
    
    @countInputs()
    @addButton()

  findFieldset: ->
    @fieldset = @afterThisElement.next('fieldset.inputs')

  findOrderedList: ->
    @orderedList = @fieldset.children().first()

  addFieldsetHtml: ->
    @afterThisElement.after('<fieldset class="inputs"></fieldset>')
    @fieldset = @afterThisElement.next()
  
  addOrderedListHtml: ->
    @fieldset.append('<ol></ol>')
    @orderedList = @fieldset.children().first()

  addButton: ->
    @fieldset.append('<button type="button">Moar</button>')
    addButton = @fieldset.children().last()
    addButton.click =>
      @addNewQuestion()

  countInputs: ->
    foundInputs = @orderedList.find('input')
    @questionNumber = foundInputs.length / 2

  addNewQuestion: ->
    @orderedList.append("<li class='string required' id='member_questions_attributes_#{@questionNumber}_content_input'><label for='member_questions_attributes_#{@questionNumber}_content'>Kysymys<abbr title='required'>*</abbr></label><input id='member_questions_attributes_#{@questionNumber}_content' maxlength='255' name='member[questions_attributes][#{@questionNumber}][content]' type='text' /></li>")

    @orderedList.find(':input:').last().select()

    @orderedList.append("<li class='string required' id='member_questions_attributes_#{@questionNumber}_answer_input'><label for='member_questions_attributes_#{@questionNumber}_answer'>Vastaus<abbr title='required'>*</abbr></label><input id='member_questions_attributes_#{@questionNumber}_answer' maxlength='255' name='member[questions_attributes][#{@questionNumber}][answer]' type='text' /></li>")

    @questionNumber++
