var gulp        = require('gulp'),
    sass        = require('gulp-sass'),
    watch       = require('gulp-watch'),
    babel       = require('gulp-babel'),
    coffee      = require('gulp-coffee'),
    browserSync = require('browser-sync').create();
    plumber     = require('gulp-plumber');

gulp.task('sass', function(){
    gulp.src('app/scss/*.scss')
    .pipe(plumber())
    .pipe(watch('app/scss/*.scss'))
    .pipe(sass())
    .pipe(gulp.dest('www/css'))
    .pipe(browserSync.stream());
});

gulp.task('sanitize', function(){
    gulp.src('css/vendor/*.css')
    .pipe(gulp.dest('www/css/vendor'));
});

// Static Server + watching scss/html files
gulp.task('serve', ['default'], function() {
    browserSync.init({
        server: "./www"
    });
    gulp.watch("app/scss/*.scss", ['sass']);
    gulp.watch("app/*.html").on('change', browserSync.reload);
});

gulp.task('html', function(){
    gulp.src('app/*.html')
    .pipe(watch('app/*.html'))
    .pipe(gulp.dest('www/'));
});

gulp.task('coffee', function(){
    gulp.src('app/js/**/*.coffee')
    .pipe(watch('app/js/**/*.coffee'))
    .pipe(coffee({
      presets: ['es2015']
    }))
    .pipe(gulp.dest('www/js/'));
});

gulp.task('move-images', function(){
  gulp.src('assets/images/*.png')
  .pipe(watch('assets/images/*.png'))
  .pipe(gulp.dest('www/assets/images'));
});

gulp.task('default', ['sass', 'sanitize', 'coffee', 'html', 'move-images']);