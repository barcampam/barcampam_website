'use strict'

const path = require('path')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const UglifyJsPlugin = require('uglifyjs-webpack-plugin')
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin')
const styleLintPlugin = require('stylelint-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const CleanWebpackPlugin = require('clean-webpack-plugin')
const Fiber = require('fibers')
const paths = require('./paths')

module.exports = (env, options) => ({
  optimization: {
    // Minify everyting in prod
    minimizer: [
      new UglifyJsPlugin({
        cache: true,
        parallel: true,
        sourceMap: false
      }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },

  resolve: {
    // Avoid relative paths when importing bases in modules
    alias: {
      '~vars': path.resolve(__dirname, '../src/css/_vars.scss'),
      '~mixins': path.resolve(__dirname, '../src/css/_mixins.scss')
    }
  },

  entry: paths.entries,

  output: {
    filename: '[name].js',
    path: paths.outputPath,
    publicPath: paths.publicPath
  },

  module: {
    rules: [
      {	// Support globs in import statements
        enforce: 'pre',
        test: /\.(js|css|scss|sass)$/,
        loader: require.resolve('webpack-import-glob'),
        exclude: /node_modules/,
      },
      { // JS pipline: Linter => Babel => output
        test: /\.js$/,
        exclude: [/node_modules/],
        use: [
          {
            loader: require.resolve('babel-loader'),
            options: { cacheDirectory: true }
          },
          {
            loader: require.resolve('eslint-loader'),
            options: { configFile: path.resolve(__dirname, '../.eslintrc') }
          }
        ]
      },
      { // Css modules (+Sass) pipline: transpile Sass => Autoprefixer => Postcss => output
        test: /\.(sass|scss|css)$/,
        use: [
          require.resolve('css-hot-loader'),
          MiniCssExtractPlugin.loader,
          require.resolve('css-loader'),
          {
            loader: require.resolve('postcss-loader'),
            options: {
              ident: 'postcss-modules',
              modules: true,
              plugins: () => [
                require('postcss-modules')({
                  globalModulePaths: [/index/],
                  generateScopedName: '[emoji:5]'
                }),
                require('autoprefixer')
              ]
            }
          },
          {
            loader: require.resolve('sass-loader'),
            options: {
              implementation: require('sass'),
              fiber: Fiber
            }
          }
        ]
      }
    ]
  },

  plugins: [
    // Shame on you if you don't know what this does
    new MiniCssExtractPlugin({
      filename: '../css/index.css'
    }),
    // Lint and format CSS in 'assets/src'
    new styleLintPlugin({
      configFile: '.stylelintrc',
      context: 'src',
      files: '**/*.{css,scss,sass}',
      failOnError: true,
      quiet: false,
      fix: true
    }),
    // Lint and format CSS in 'lib'
    // new styleLintPlugin({
    //   configFile: '.stylelintrc',
    //   context: '../lib',
    //   files: '**/*.{css,scss,sass}',
    //   failOnError: true,
    //   quiet: false,
    //   fix: true
    // }),
    // Deletes the contents of the destination directory
    // new CleanWebpackPlugin(
    //   [path.join(paths.outputPath, '../')],
    //   { verbose: false, allowExternal: true, ignore: ['docs', 'toolkit'] }
    // ),
    // Copys files only, doesn't do anything else
    new CopyWebpackPlugin(
      [{ from: 'static/', to: '../' }],
      { ignore: ['.DS_Store'] }
    )
  ],

  // Keep it clean
  stats: {
    colors: !/^win/i.test(process.platform),
    modules: false,
    children: false
  }
})
