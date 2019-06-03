'use strict'

const path = require('path')

module.exports = {
  publicPath: '/',
  sourcePath: path.resolve(__dirname, '../src'),
  outputPath: path.resolve(__dirname, '../../priv/static/js'),
	entries: { index: path.resolve(__dirname, '../src/index.js') }
}
