module.exports = function(grunt) {
  'use strict';

  require('load-grunt-tasks')(grunt);

  grunt.initConfig({

    watch: {
      js: {
        files: ['client/**/*.js'],
        tasks: ['js']
      }
    },

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

  grunt.registerTask('js', [
    'browserify'
  ]);

  grunt.registerTask('default', [
    'js', 'watch'
  ]);
};
