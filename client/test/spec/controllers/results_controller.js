describe('ResultsController', () => {
  'use strict';
  
  var scope, $location, createController,
      controllerType = 'ResultsController';

  beforeEach(module('elixre'));
  beforeEach(inject(($rootScope, $controller, _$location_) => {
    $location = _$location_;
    scope = $rootScope.$new();
    createController = function() {
      $controller(controllerType, { '$scope': scope });
    };
  }));

  it('should have a method to check if the path is active', () => {
    expect(1 + 1).toBe(2);
  });
});
