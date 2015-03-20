require('angular');

import { TestController } from './controllers/test_controller.js';

angular
  .module('elixre', [])
  .controller('TestController', TestController);
