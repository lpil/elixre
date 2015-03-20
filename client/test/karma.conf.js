// Karma configuration
// Generated on Fri Mar 20 2015 13:53:12 GMT+0000 (GMT)

module.exports = function(config) {
  'use strict';
  
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '../..',

    frameworks: ['jasmine'],

    // list of files / patterns to load in the browser
    files: [
      'priv/static/main.js',
      'client/test/**/*.js'
    ],

    exclude: [
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors:
    //  https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
    },

    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress'],

    // web server port
    port: 9876,

    // enable / disable colors in the output (reporters and logs)
    colors: true,

    logLevel: config.LOG_INFO,

    autoWatch: false,

    browsers: ['PhantomJS'],

    singleRun: true
  });
};
