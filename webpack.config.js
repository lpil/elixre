module.exports = {
  entry: "./js/main.js",
  output: {
    path: "./public",
    filename: "./main.js",
  },

  devtool: "#inline-source-map",

  module: {
    loaders: [
      {
        test: /\.js$/,
        loader: "babel-loader",
        query: { presets: ["es2015"], },
      },
    ],
  },
};
