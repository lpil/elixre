module.exports = function(grunt) {
  'use strict';

  require('load-grunt-tasks')(grunt);

  grunt.initConfig({

    watch: {
      js: {
        files: ['client/**/*.js'],
        tasks: ['js', 'karma:test']
      },
      scss: {
        files: ['client/**/*.scss'],
        tasks: ['scss']
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
    },

    sass: {
      options: {
        sourceMap: true
      },
      compile: {
        files: {
          'priv/static/main.css': 'client/styles/main.scss'
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

  grunt.registerTask('scss', [
    'sass'
  ]);

  grunt.registerTask('default', [
    'scss', 'js', 'karma:test', 'watch'
  ]);
};
