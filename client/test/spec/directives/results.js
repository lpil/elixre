describe('resultDirective', () => {
  'use strict';

  var $compile, $rootScope, $scope, ele;

  beforeEach(module('elixre'));

  beforeEach(inject((_$rootScope_, $sce, _$compile_) => {
    $compile   = _$compile_;
    $rootScope = _$rootScope_;
    $scope = $rootScope.$new();
    $scope.data = {
      subject: $sce.trustAsHtml('<h1>X</h1>'),
      result: ['hello']
    };
    ele = $compile('<result data="data">')($scope);
  }));

  it('compiles to the correct content', () => {
    $rootScope.$digest();
    expect(ele.html()).toBe(
`<span ng-bind-html="data.subject" class="ng-binding"><h1>X</h1></span>
[
  "hello"
]`
    );
  });

  it('defaults to an empty array when no result', () => {
    delete $scope.data.result;
    $rootScope.$digest();
    expect(ele.html()).toBe(
`<span ng-bind-html="data.subject" class="ng-binding"><h1>X</h1></span>
[]`
    );
  });
});
