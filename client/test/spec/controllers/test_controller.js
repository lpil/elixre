describe('testController', () => {
  'use strict';
  
  var $httpBackend, $scope, createController,
      controllerType = 'testController';

  beforeEach(module('elixre'));
  beforeEach(inject(($rootScope, $controller, _$httpBackend_) => {
    $scope = $rootScope.$new();
    $httpBackend = _$httpBackend_;
    createController = function() {
      return $controller(controllerType, { '$scope': $scope });
    };
    $httpBackend.when('POST', '/test').respond({some: 'data'});
  }));

  afterEach(() => {
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });


  describe('.test', () => {
    it('sends data to server', () => {
      $httpBackend.expectPOST('/test', { regex: '.', subject: ['foo']});
      createController().test('.', 'foo');
      $httpBackend.flush();
    });

    it('splits subject when $scope.split is true', () => {
      $httpBackend.expectPOST('/test', { regex: '.', subject: ['a', 'b']});
      $scope.split = true;
      createController().test('.', 'a\nb');
      $httpBackend.flush();
    });

    it('does not split subject when $scope.split is false', () => {
      var ctrl = createController();
      $httpBackend.expectPOST('/test', { regex: '.', subject: 'a\nb'});
      $scope.split = false;
      ctrl.test('.', 'a\nb');
      $httpBackend.flush();
    });

    it('sets $scope.return with the return value', () => {
      createController().test('.', 'foo');
      $httpBackend.flush();
      expect($scope.return).toEqual({some: 'data'});
    });
  });

});
