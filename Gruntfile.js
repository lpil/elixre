module.exports = function(grunt) {
  'use strict';

  require('load-grunt-tasks')(grunt);

  grunt.initConfig({

    watch: {
      js: {
        files: ['client/**/*.js'],
        tasks: ['js', 'karma:test']
      },
      sass: {
        files: ['client/**/*.scss'],
        tasks: ['sass:dev']
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

    uglify: {
      options: {
        mangle: {
          except: [
            '$scope',
            '$http',
            '$sce'
          ]
        }
      },
      dist: {
        files: {
          'priv/static/main.js': 'priv/static/main.js'
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
      dev: {
        files: {
          'priv/static/main.css': 'client/styles/main.scss'
        }
      },
      prod: {
        options: {
          outputStyle: 'compressed',
          sourceMap: false
        },
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

  grunt.registerTask('build', [
    'sass:prod', 'js', 'uglify'
  ]);

  grunt.registerTask('default', [
    'sass:dev', 'js', 'karma:test', 'watch'
  ]);
};
