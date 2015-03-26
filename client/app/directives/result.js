'use strict';

function resultDirective() {
  return {
    restrict: 'E',

    scope: {
      data: '='
    },

    template:
`# {{ data.subject }}
{{ data.result || [] | json }}`
  };
}

export { resultDirective };
