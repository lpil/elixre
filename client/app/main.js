require('angular');

import { TestController } from './controllers/test_controller';
import { ResultsController } from './controllers/results_controller';

import { resultDirective } from './directives/result';

angular
  .module('elixre', [])
  .controller('testController', TestController)
  .controller('resultsController', ResultsController)
  .directive('result', resultDirective);
