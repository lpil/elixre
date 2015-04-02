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
    var index = subject.indexOf(match),
        start = subject.slice(0, index),
        end   = subject.slice(index + match.length);
    subject = `${start}<span class="hl">${match}</span>${end}`;
    return subject;
  };

  var transformReturn = function(ret) {
    var sub = ret.subject;
    if (ret.result) { sub = hightlightMatch(sub, ret.result[0]); }
    ret.subject = $sce.trustAsHtml(sub);
    return ret;
  };

  $scope.$watch('return', () => {
    if (!$scope.return) { return; }
    $scope.return.results = $scope.return.results.map(transformReturn);
  });
}

export { ResultsController };
