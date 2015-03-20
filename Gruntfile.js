module.exports = function(grunt) {
  'use strict';

  require('load-grunt-tasks')(grunt);

  grunt.initConfig({

    watch: {
      js: {
        files: ['client/**/*.js'],
        tasks: ['js']
      },
      test: {
        files: ['client/**/*.js'],
        tasks: ['karma:test:run']
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
    },

    karma: {
      test: {
        options: {
          configFile: 'client/test/karma.conf.js'
        }
      }
    }
  });

  grunt.registerTask('test', [
    'browserify', 'karma:test'
  ]);

  grunt.registerTask('js', [
    'browserify'
  ]);

  grunt.registerTask('default', [
    'js', 'karma:test', 'watch'
  ]);
};
