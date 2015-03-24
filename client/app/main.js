require('angular');

import { TestController } from './controllers/test_controller';

import { resultsDirective } from './directives/results';

angular
  .module('elixre', [])
  .controller('testController', TestController)
  .directive('results', resultsDirective);
