require('angular');

import { TestController    } from './controllers/test_controller';
import { ResultsController } from './controllers/results_controller';
import { resultDirective   } from './directives/result';

const dependencies = [
  require('angular-sanitize')
];

angular
  .module('elixre', dependencies)
  .controller('testController', TestController)
  .controller('resultsController', ResultsController)
  .directive('result', resultDirective);
