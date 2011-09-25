var MemberSearch;
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
MemberSearch = (function() {
  function MemberSearch() {
    this.memberList = $('#role-');
    this.searchField = $('#member-search').find('input');
    this.searchField.bind('textchange', __bind(function(event) {
      return this.filterMemberList(event.currentTarget.value);
    }, this));
  }
  MemberSearch.prototype.filterMemberList = function(text) {
    this.filterText = text.toLowerCase();
    return this.memberList.find('li').each(__bind(function(index, li) {
      return this.checkMemberItem($(li));
    }, this));
  };
  MemberSearch.prototype.checkMemberItem = function(item) {
    if (this.containsFilterTextCheck(item.text())) {
      return item.show();
    } else {
      return item.hide();
    }
  };
  MemberSearch.prototype.containsFilterTextCheck = function(text) {
    return text.toLowerCase().indexOf(this.filterText) !== -1;
  };
  return MemberSearch;
})();