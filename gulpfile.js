'use strict';

var gulp = require('gulp');
var source = require('vinyl-source-stream');
var sass = require('gulp-sass');
var coffeeify = require('gulp-coffeeify');
var jade = require('gulp-jade')


gulp.task('default', ['scripts', 'jade', 'sass']);

gulp.task('scripts', function () {
  gulp.src('./src/scripts/**/*.coffee')
    .pipe(coffeeify({
      options: {
        debug: true,
        paths: [__dirname + '/node_modules', __dirname + '/src/scripts']
      }
    }))
    .pipe(gulp.dest('./www/scripts'));
});

gulp.task('sass', function () {
  gulp.src('./src/*.sass')
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./www'));
});

gulp.task('jade', function () {
  gulp.src('./src/index.jade')
    .pipe(jade({
      pretty: true
    }))
    .pipe(gulp.dest('./www/'))
});