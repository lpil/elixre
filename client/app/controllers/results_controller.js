'use strict';

function ResultsController($scope, $sce) {
  /**
   * Wraps the subject's match substring in a highlight span
   *
   * @param {string} subject The string to highlighted
   * @param {string} match The substring of the subject
   * @returns {string} The subject with the match highlighted
   */
  var hightlightMatch = function(subject, match) {
    console.log(subject, match);
    if (match) {
      var index = subject.indexOf(match),
          start = subject.slice(0, index),
          end   = subject.slice(index + match.length);
      subject = `${start}<span class="hl">${match}</span>${end}`;
    }
    return subject;
  };

  var transformReturn = function(x) {
    var match;
    if (x.result) { match = x.result[0]; }
    x.subject = $sce.trustAsHtml(hightlightMatch(x.subject, match));
    return x;
  };

  $scope.$watch('return', () => {
    if (!$scope.return) { return; }
    $scope.return.results = $scope.return.results.map(transformReturn);
  });
}

export { ResultsController };
