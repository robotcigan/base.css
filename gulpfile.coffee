gulp = require 'gulp'
stylus = require 'gulp-stylus'
autoprefixer = require 'gulp-autoprefixer'
concat = require 'gulp-concat'
jade = require 'gulp-jade'
coffee = require 'gulp-coffee'
browserSync = require 'browser-sync'
reload = browserSync.reload


gulp.task 'stylus', ->
	gulp.src 'styles/*.styl'
		.pipe do stylus
		.on 'error', (err) ->
			console.log err
		.pipe autoprefixer({browsers: ['> 1%', 'last 5 version','IE 10'], cascade: false})
		.pipe gulp.dest 'styles/css/'
		.pipe(reload({stream: true}))

gulp.task 'concat', ->
	gulp.src ['styles/css/normalize.css', 'styles/css/bootstrap-grid.min.css', 'styles/css/font-awesome.min.css', 'styles/css/animate.min.css']
		.pipe concat 'libs.css'
		.pipe gulp.dest 'styles/css'


gulp.task 'jade', ->
	gulp.src '*.jade'
		.pipe jade {pretty: true}
		.pipe gulp.dest ''


gulp.task 'coffee', ->
	gulp.src('js/*.coffee')
		.pipe(coffee(bare: true))
		.pipe gulp.dest('js/')
		.pipe(reload({stream: true}))


gulp.task('jade-watch', ['jade'], reload)

gulp.task 'watch', ->
	gulp.watch 'styles/*.styl', ['stylus']
	gulp.watch 'js/*.coffee',   ['coffee']
	gulp.watch '*.jade',        ['jade']


gulp.task 'default', ['jade', 'stylus', 'concat', 'coffee','watch'], ->

	browserSync {server: './'}

	gulp.watch('styles/css/*.css', ['stylus'])
	gulp.watch('js/*.js',          ['coffee'])
	gulp.watch('*.html',           ['jade-watch'])