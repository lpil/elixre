'use strict';

function ResultsController($scope, $sce) {
  /**
   * Wraps the subject's match substring in a highlight span
   *
   * @param {string} subject The string to highlighted
   * @param {int} index Match start char index
   * @param {int} length Match length
   * @returns {string} The subject with the match highlighted
   */
  var hightlightMatch = function(subject, index, length) {
    var start = subject.slice(0, index),
        match = subject.slice(index, index + length),
        end   = subject.slice(index + length);
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
    var subject = ret.subject, s, l;
    if (ret.result) {
      [s, l]  = ret.indexes[0];
      subject = hightlightMatch(subject, s, l);
    }
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
