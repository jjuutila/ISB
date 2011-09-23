$ = jQuery

$.fn.extend 
  monitorStandings: () ->
    self = $.fn.monitorStandings
    $(this).find('input').numeric()
    
    # Sortable jQuery UI
    $(this).sortable({ cursor: 'move' })
    
    $(this).find('input').bind 'textchange', (event) =>
      self.updateValues(event.currentTarget)
      
      if $('#auto_sort_standings').is(':checked')
        $(this).find('tr').sortElements (a, b) ->
          self.compare(a, b)

$.extend $.fn.monitorStandings,
  updateValues: (target) ->
    row = $(target).parents 'tr'
    @updatePoints row
    @updateGamesPlayed row
  
  updatePoints: (row) ->
    points = @calculatePoints(row.find('input'))
    pointsElement = row.find '.points-cell'
    pointsElement.text points
    
  calculatePoints: (inputs) ->
    # wins, overtimes, losses
    2 * parseInt(inputs[0].value) + parseInt(inputs[1].value)
    
  updateGamesPlayed: (row) ->
    gamesPlayed = @calculateGamesPlayed(row.find('input'))
    gamesPlayedElement = row.find '.games-played-cell'
    gamesPlayedElement.text gamesPlayed
    
  calculateGamesPlayed: (inputs) ->
    parseInt(inputs[0].value) + parseInt(inputs[1].value) + parseInt(inputs[2].value)

  compare: (a, b) ->    
    pointDifference = @calculatePointDifference(a, b)
    return if pointDifference != 0 then pointDifference else @calculateGoalsDifference(a, b)
      
  calculatePointDifference: (a, b) ->
    pointsA = parseInt($(a).find('.points-cell').text())
    pointsB = parseInt($(b).find('.points-cell').text())
    pointsB - pointsA
    
  calculateGoalsDifference: (a, b) ->
    aInputs = $(a).find('input')
    aGoalRatio = parseInt(aInputs[3].value) - parseInt(aInputs[4].value)
    
    bInputs = $(b).find('input')
    bGoalRatio = parseInt(bInputs[3].value) - parseInt(bInputs[4].value)
    
    if aGoalRatio > bGoalRatio
      return -1
    if bGoalRatio > aGoalRatio
      return +1
    else
      0
