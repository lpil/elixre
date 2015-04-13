describe('resultsController', () => {
  'use strict';
  
  var $scope, createController,
      controllerType = 'resultsController';

  beforeEach(module('elixre'));

  beforeEach(inject(($rootScope, $controller) => {
    $scope = $rootScope.$new();
    createController = function() {
      return $controller(controllerType, { '$scope': $scope });
    };
  }));

  describe('.comment', () => {
    it('returns the input with lines prefixed', () => {
      var func     = createController().comment,
          input    = 'Hello\nWorld',
          expected = `<span class="no-hl"># </span>Hello
<span class="no-hl"># </span>World`;

      expect(func(input)).toBe(expected);
    });
  });

  describe('.hightlightMatch', () => {
    it('wraps the match substring in a span.hl', () => {
      var func     = createController().hightlightMatch,
          subject  = 'Hello World',
          start    = 2,
          length   = 3,
          expected = 'He<span class="hl">llo</span> World';

      expect(func(subject, start, length)).toBe(expected);
    });
  });


  describe('.transformReturn', () => {
    describe('return value subject property', () => {
      it('is trusted HTML', () => {
        var ctrl   = createController(),
            args   = { subject: 'foobar', result: ['foo'], indexes: [[0, 3]] },
            result = ctrl.transformReturn(args);
        expect(result.subject.$$unwrapTrustedValue).toBeDefined();
      });

      it('highlights subject match if there is one', () => {
        var ctrl   = createController(),
            ideal = /<span class="hl">foo<\/span>bar/,
            args   = { subject: 'foobar', result: ['foo'], indexes: [[0, 3]] },
            result = ctrl.transformReturn(args),
            html = result.subject.$$unwrapTrustedValue();

        expect(html).toMatch(ideal);
      });

      it('does not highlight subject with no match', () => {
        var ctrl     = createController(),
            hlString = /<span class="hl">.*<\/span>/,
            args     = { subject: 'foobar', result: null },
            result   = ctrl.transformReturn(args),
            html = result.subject.$$unwrapTrustedValue();

        expect(html).not.toMatch(hlString);
      });

      it('prefixes with comments', () => {
        var ctrl    = createController(),
            expected = '<span class="not-hl"># <\/span>foobar',
            args    = { subject: 'foobar', result: null },
            result  = ctrl.transformReturn(args),
            html = result.subject.$$unwrapTrustedValue();

        expect(html).not.toMatch(expected);
      });
    });
  });
});
