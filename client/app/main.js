require('angular');

import { TestController } from './controllers/test_controller';

angular
  .module('elixre', [])
  .controller('testController', TestController);
