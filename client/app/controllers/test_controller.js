'use strict';

class TestController {
  constructor($scope, $http) {
    $scope.test    = this.test;
    $scope.http    = $http;
    $scope.regex   = '';
    $scope.subject = '';
  }

  test() {
    var args = {
      regex: this.regex,
      subject: this.subject.split('\n')
    };

    this.http.post('/test', args)
      .success(data => console.log(data))
      .error(data => console.log(data));
  }
}

export { TestController };
