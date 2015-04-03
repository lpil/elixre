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

  /**
   * Prefix each line of a string with a span.no-hl of "# "
   *
   * @param {string} lines
   * @returns {string}
   */
  var comment = function(lines) {
    var prefix = '<span class="no-hl"># </span>';
    return prefix + lines.split('\n').join('\n' + prefix);
  };

  /**
   * Highlights
   *
   * @param {object} ret The object returned from the test API
   * @returns {object} ret with the subject highlighted & comment prefixed
   */
  var transformReturn = function(ret) {
    var subject = ret.subject;
    if (ret.result) { subject = hightlightMatch(subject, ret.result[0]); }
    subject     = comment(subject);
    ret.subject = $sce.trustAsHtml(subject);
    return ret;
  };

  $scope.$watch('return', () => {
    if (!$scope.return) { return; }
    var ret = $scope.return;
    if (!ret.error) {
      ret.results = ret.results.map(transformReturn);
    }
  });


  this.comment         = comment;
  this.hightlightMatch = hightlightMatch;
  this.transformReturn = transformReturn;
}

export { ResultsController };
