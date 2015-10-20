'use strict';
var gulp = require('gulp'),
    del = require('del'),
    sourcemaps = require('gulp-sourcemaps'),
    tsc  = require('gulp-typescript'),
    tslint = require('gulp-tslint'),
    tsProject = tsc.createProject('tsconfig.json');

var config = {
    allTypeScript: './lib_ts/**/*.ts',
    tsOutputPath: './lib',
    libraryTypeScriptDefinitions: './typings/**/*.ts'
}

/**
 * Compile TypeScript and include references to library and app .d.ts files.
 */
gulp.task('compile-ts', function () {
    var sourceTsFiles = [config.allTypeScript,                //path to typescript files
        config.libraryTypeScriptDefinitions]; //reference to library .d.ts files


    var tsResult = gulp.src(sourceTsFiles)
        .pipe(sourcemaps.init())
        .pipe(tsc(tsProject));

    tsResult.dts.pipe(gulp.dest(config.tsOutputPath));
    return tsResult.js
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest(config.tsOutputPath));
});

/**
 * Lint all custom TypeScript files.
 */
gulp.task('ts-lint', function () {
    return gulp.src(config.allTypeScript).pipe(tslint()).pipe(tslint.report('prose'));
});

/**
 * Remove all generated JavaScript files from TypeScript compilation.
 */
gulp.task('clean-ts', function (cb) {
    var typeScriptGenFiles = [
        config.tsOutputPath +'/**/*.js',    // path to all JS files auto gen'd by editor
        config.tsOutputPath +'/**/*.js.map', // path to all sourcemap files auto gen'd by editor
        '!' + config.tsOutputPath + '/lib'
    ];

    // delete the files
    del(typeScriptGenFiles, cb);
});

gulp.task('watch', function() {
    //gulp.watch([config.allTypeScript], ['ts-lint', 'compile-ts']);
    gulp.watch([config.allTypeScript], ['compile-ts']);
});
