class QAItemHandler
  constructor: (@container) ->
    @questionNumber = 0
    
  init: ->
    @addMoreButton()
    @addRemoveButtons()
  
  addOrderedListHtml: ->
    @fieldset.append('<ol></ol>')
    @orderedList = @fieldset.children().first()
    
  addMoreButton: ->
    addButton = $('<button type="button" class="new-question"><img alt="Add" src="/images/add.png" /> Uusi kysymys</button>')
    @container.after(addButton)
    addButton.click =>
      @addNewQuestion()

  addRemoveButtons: ->
    #@container.children('fieldset').append(@createRemoveButton())
    @container.children('fieldset').each (index, fieldset) =>
      $(fieldset).append(@createRemoveButton())
      @questionNumber++

    
  createRemoveButton: ->
    removeButton = $('<button type="button" class="remove-question"><img alt="cross" src="/images/cross.png" /></button>')
    removeButton.bind 'click', {questionIndex: @questionNumber}, (event) =>
      @removeQuestion(event)
      
    removeButton

  removeQuestion: (event) ->
    @markForDestruction(event.data.questionIndex)
    $(event.target).parent().remove()


  markForDestruction: (index) ->
    idInput = @container.children("#member_questions_attributes_#{index}_id")
    if idInput.length == 1
      hiddenInput = $("<input id='member_questions_attributes_#{index}_destroy' name='member[questions_attributes][#{index}][_destroy]' type='hidden' value='1' />")
      @container.append(hiddenInput)

  addNewQuestion: ->
    fieldset = $('<fieldset class="inputs"></fieldset>')
    @container.append(fieldset)
    
    orderedList = $('<ol></ol>')
    fieldset.append(orderedList)
    
    orderedList.append("<li class='string required inline-input' id='member_questions_attributes_#{@questionNumber}_content_input'><label for='member_questions_attributes_#{@questionNumber}_content'>Kysymys<abbr title='required'>*</abbr></label><input id='member_questions_attributes_#{@questionNumber}_content' maxlength='255' name='member[questions_attributes][#{@questionNumber}][content]' type='text' /></li>")

    orderedList.find(':input:').last().select()

    orderedList.append("<li class='string required inline-input' id='member_questions_attributes_#{@questionNumber}_answer_input'><label for='member_questions_attributes_#{@questionNumber}_answer'>Vastaus<abbr title='required'>*</abbr></label><input id='member_questions_attributes_#{@questionNumber}_answer' maxlength='255' name='member[questions_attributes][#{@questionNumber}][answer]' type='text' /></li>")
    
    fieldset.append(@createRemoveButton())
    @questionNumber++