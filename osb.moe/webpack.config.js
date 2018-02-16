const webpack = require('webpack');
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const BUILD_DIR = path.resolve(__dirname, './public');
const APP_DIR = path.resolve(__dirname, './src');
const STATIC_DIR = path.resolve(__dirname, './static');

console.log('build', BUILD_DIR, 'app', APP_DIR, 'static', STATIC_DIR);

const config = {
  entry: {
    index: `${APP_DIR}/index.jsx`
  },
  output: {
    path: BUILD_DIR,
    filename: '[name].[hash].js'
  },
  plugins: [
    new CleanWebpackPlugin([BUILD_DIR]),
    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify(process.env.NODE_ENV) }
    }),
    new HtmlWebpackPlugin({
      template: `${APP_DIR}/index.html`,
      filename: `${BUILD_DIR}/index.html`,
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: "vendor",
      minChunks: module => {
        // This prevents stylesheet resources with the .css or .scss extension
        // from being moved from their original chunk to the vendor chunk
        if(module.resource && (/^.*\.(css|scss)$/).test(module.resource)) {
          return false;
        }

        return module.context && module.context.includes("node_modules");
      }
    }),
    new CopyWebpackPlugin([
      { from: STATIC_DIR, BUILD_DIR }
    ])
  ],
  module: {
    rules: [
      {
        include: APP_DIR,
        exclude: /(node_modules)/,
        test: /\.(js|jsx)$/,
        loader: 'babel-loader',
        query: {
          presets: [ 'es2015', 'react', 'stage-2' ]
        }
      },
      {
        test: /\.(png|jpg|gif)$/,
        loader: 'url-loader'
      }
    ]
  },
  /* Some linux distibutions seem to have a problem without poll=true */
  watchOptions: {
    poll: true
  },
  devServer: {
    contentBase: path.join(__dirname, "./public"),
    port: '3000'
  },
  resolve: {
    extensions: [ '.js', '.jsx' ],
    modules: [
      'node_modules',
      path.resolve(__dirname, './src')
    ]
  }
};

if (process.env.NODE_ENV === 'production') {
  config.plugins.push(
    new webpack.optimize.UglifyJsPlugin()
  );
} else {
  config.devtool = 'source-map';
}

module.exports = config;
