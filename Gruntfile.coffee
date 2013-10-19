module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-coffee-coverage'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-text-replace'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    browserify:
      lib:
        files:
          'lib/<%= pkg.name %>.js': './build/<%= pkg.name %>.js'

    clean:
      build_files: [
        'build', 'lib/*'
        'test/coverage.html'
      ]

    coffee:
      compile:
        files:
          './build/<%= pkg.name %>.js': [
            'src/tome_namespace.coffee'
            'src/**/*.coffee'
          ]

    coffeeCoverage:
      options:
        exclude: ['src', 'test', 'lib']
      build: './build'

    copy:
      source:
        files: [expand: true, cwd: 'src', src: '**', dest: 'build']

    mochaTest:
      run_tests:
        options:
          reporter: 'spec'
          require: ['coffee-script', 'test/test_helper.coffee']
        src: ['**/*_test.coffee']

      coverage_report:
        options:
          reporter: 'html-cov'
          quiet: true
          captureFile: 'test/coverage.html'
        src: ['test/**/*.coffee']

      travis_ci_coverage:
        options:
          reporter: 'travis-cov'
        src: ['test/**/*.coffee']

    replace:
      pkg_info:
        src: './build/<%= pkg.name %>.js'
        dest: './build/<%= pkg.name %>.js'
        replacements: [
          from: '$VERSION$'
          to: '<%= pkg.version %>'
        ]
  
  grunt.task.registerTask 'default', ['clean', 'compile', 'test']
  grunt.task.registerTask 'compile', ['coffee:compile', 'copy:source', 'replace:pkg_info', 'browserify:lib']
  grunt.registerTask 'test', ['coffeeCoverage', 'mochaTest']
