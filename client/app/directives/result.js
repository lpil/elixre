'use strict';

function resultDirective() {
  return {
    restrict: 'E',

    scope: {
      data: '='
    },

    link: (scope) => {
      scope.data.subject = `# ${scope.data.subject.split('\n').join('\n# ')}`;
    },

    template:
`{{ data.subject }}
{{ data.result || [] | json }}`
  };
}

export { resultDirective };
