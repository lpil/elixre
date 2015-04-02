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

  var comment = function(str) {
    var prefix = '<span class="no-hl"># </span>';
    return prefix + str.split('\n').join('\n' + prefix);
  };

  var transformReturn = function(ret) {
    var subject = ret.subject;
    if (ret.result) { subject = hightlightMatch(subject, ret.result[0]); }
    subject     = comment(subject);
    ret.subject = $sce.trustAsHtml(subject);
    return ret;
  };

  $scope.$watch('return', () => {
    if (!$scope.return) { return; }
    $scope.return.results = $scope.return.results.map(transformReturn);
  });
}

export { ResultsController };
