var path              = require('path');
var webpack           = require('webpack');
var merge             = require('webpack-merge');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var autoprefixer      = require('autoprefixer');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'production' : 'development';

var commonConfig = {
  output: {
    path:     path.resolve(__dirname, 'dist/'),
    filename: '[hash].js',
  },

  // resolve: {
  //   modulesDirectories: ['node_modules'],
  //   extensions:         ['', '.js', '.elm']
  // },

  module: {
    noParse: /\.elm$/,
    loaders: [
      {
        test: /\.(eot|ttf|woff|woff2|svg)$/,
        loader: 'file-loader'
      },
      {
        test: /\.(css|scss)$/,
        loader: ExtractTextPlugin.extract('style-loader', [
          'css-loader',
          'postcss-loader',
          'sass-loader'
        ])
      }
    ]
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: 'client/index.html',
      inject:   'body',
      filename: 'index.html'
    }),

    new ExtractTextPlugin('./[hash].css', { allChunks: true }),
  ],

  postcss: [ autoprefixer( { browsers: ['last 2 versions'] } ) ],
}

if (TARGET_ENV === 'development') {
  console.log('Serving locally...');

  module.exports = merge(commonConfig, {

    entry: [
      'webpack-dev-server/client?http://localhost:8080',
      path.join(__dirname, 'client/index.js')
    ],

    devServer: {
      inline:   true,
      progress: true
    },

    module: {
      loaders: [
        {
          test:    /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader:  'elm-hot!elm-webpack?verbose=true&warn=true'
        },
      ],
    },
  });
}

if (TARGET_ENV === 'production') {
  console.log('Building for prod...');

  module.exports = merge(commonConfig, {

    entry: path.join(__dirname, 'src/index.js'),

    module: {
      loaders: [
        {
          test:    /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader:  'elm-webpack'
        }
      ]
    },

    plugins: [
      new webpack.optimize.OccurenceOrderPlugin(),

      new webpack.optimize.UglifyJsPlugin({
          minimize:   true,
          compressor: { warnings: false }
      })
    ]
  });
}
