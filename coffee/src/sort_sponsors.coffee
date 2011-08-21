$ = jQuery

$.fn.extend 
  sortSponsors: () ->
    self = $.fn.sortSponsors
    self.init()

$.extend $.fn.sortSponsors,
  init: () ->
    @sortButton = $('button#sort-sponsors')
    @actionsContainer = $('#sort-actions')
    $('tbody').sortable({ disabled: true, cursor: 'move' })

    @setAsSortButton()
  
  setAsSortButton: ->
    @sortButton.text('Muokkaa järjestystä')
    @sortButton.bind 'click', (event) =>
      @beginSorting()
      
  beginSorting: ->
    @saveOriginalSponsorList()
    @addCancelButton()    
    @setSortButtonAsSave()
    @setAsSortable()
    
  saveOriginalSponsorList: ->
    @originalSponsorList = $('tbody').find('tr')
    
  addCancelButton: ->
    @cancelButton = $('<button id="cancel-sorting" type="button">Peruuta</button>')
    @actionsContainer.append(@cancelButton)
    @cancelButton.bind 'click', (event) =>
      @cancelSorting()
    
  setAsSortable: ->
    $('tbody').sortable("option", "disabled", false)
    $('tbody').addClass('sortable-sponsors')
    $('.sponsor-actions').hide()
    
  setAsNotSortable: ->
    $('tbody').sortable("option", "disabled", true)
    $('tbody').removeClass('sortable-sponsors')
    $('.sponsor-actions').show()
    
  setSortButtonAsSave: ->
    @sortButton.unbind('click')
    @sortButton.text('Tallenna')
    @sortButton.bind 'click', (event) =>
      @savePositions()
      
  savePositions: ->
    @setAsSortButton()
    @setAsNotSortable()
    @cancelButton.remove()
    
    positions = @getPositions()
    $.ajax({
      url: "sponsors/positions.js",
      data: {positions: positions},
      type: 'PUT'
      })
    
  getPositions: ->
    positions = []
    $('tbody').find('tr').each (index, tr) ->
      id = parseInt($(tr).attr('id').split('-')[1])
      positions.push(id)
    positions
    
  cancelSorting: ->
    @cancelButton.remove()
    $('tbody').html(@originalSponsorList)
    @sortButton.unbind('click')
    @setAsSortButton()
    @setAsNotSortable()
