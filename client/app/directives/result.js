'use strict';

function resultDirective() {
  return {
    restrict: 'E',

    scope: {
      data: '='
    },

    template:
`<span ng-bind-html="data.subject"></span>
{{ data.result || [] | json }}`
  };
}

export { resultDirective };
