module.exports = function(grunt) {
  'use strict';

  require('load-grunt-tasks')(grunt);

  grunt.initConfig({

    browserify: {
      options: {
        transform: ['babelify']
      },
      dist: {
        files: {
          'priv/static/main.js': 'client/app/main.js'
        }
      }
    }
  });

  grunt.registerTask('default', [
    'browserify'
  ]);
};
