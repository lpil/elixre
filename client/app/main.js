require('angular');

import { TestController } from './controllers/test_controller';

import { resultDirective } from './directives/result';

angular
  .module('elixre', [])
  .controller('testController', TestController)
  .directive('result', resultDirective);
