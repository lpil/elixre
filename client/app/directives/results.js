'use strict';

function resultsDirective() {
  const defaultData = { regex: '', results: [] };

  return {
    restrict: 'E',

    scope: {
      data: '='
    },

    link: scope => {
      scope.data = defaultData;

      scope.$watch('data', () => {
        var { regex, results } = scope.data;
        scope.regex   = regex;
        scope.results = results;
      });
    },

    template: `
<h3 ng-bind="regex"></h3>
<pre ng-bind="results | json"></pre>
`
  };
}

export { resultsDirective };
