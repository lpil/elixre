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
      var comment  = createController().comment,
          input    = 'Hello\nWorld',
          expected = `<span class="no-hl"># </span>Hello
<span class="no-hl"># </span>World`;

      expect(comment(input)).toBe(expected);
    });
  });
});
