'use strict';

function resultsDirective() {
  return {
    scope: {
      data: '='
    },
    template: `<pre ng-bind="data | json"></pre>`
  };
}

export { resultsDirective };
