describe('ResultsController', () => {
  'use strict';
  
  var scope, createController,
      controllerType = 'resultsController';

  beforeEach(module('elixre'));
  beforeEach(inject(($rootScope, $controller) => {
    scope = $rootScope.$new();
    createController = function() {
      return $controller(controllerType, { '$scope': scope });
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
          match    = 'llo',
          expected = 'He<span class="hl">llo</span> World';

      expect(func(subject, match)).toBe(expected);
    });
  });
});
