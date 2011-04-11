class MemberSearch
  constructor: () ->
    @memberList = $('#role-')
    
    @searchField = $('#member-search').find('input')
    @searchField.bind 'textchange', (event) =>
      @filterMemberList(event.currentTarget.value)

  filterMemberList: (text) ->
    @filterText = text.toLowerCase()
    
    @memberList.find('li').each (index, li) =>
      @checkMemberItem($(li))
        
  checkMemberItem: (item) ->
    if @containsFilterTextCheck(item.text())
      item.show()
    else
      item.hide()
  
  containsFilterTextCheck: (text) ->
    text.toLowerCase().indexOf(@filterText) != -1