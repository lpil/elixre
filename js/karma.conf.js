var webpack      = require("karma-webpack");
var js_pattern  = "**/*.js";
var test_pattern = "**/*_test.js";

var preprocessors = {};
preprocessors[js_pattern] = ["webpack"];
preprocessors[test_pattern] = ["webpack"];

module.exports = function (config) {
  config.set({

    basePath:   ".",
    files:      [test_pattern],
    exclude:    [],
    reporters:  ["progress"],
    frameworks: ["mocha", "chai"],
    colors:     true,

    plugins: [
      "karma-webpack",
      "karma-chai",
      "karma-phantomjs-launcher",
      "karma-mocha"
    ],

    browsers: [ "PhantomJS" ],
    preprocessors: preprocessors,

    webpack: require("./webpack.config.js"),
    webpackMiddleware: { noInfo: true }
  });
};
