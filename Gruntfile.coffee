#
# grunt-lorax
# https://github.com/adrianlee44/grunt-lorax
#
# Copyright (c) 2014 Adrian Lee
# Licensed under the MIT license.
#
module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    coffeelint:
      all: ["Gruntfile.coffee", "tasks/*.coffee", "<%= nodeunit.tests %>"]


    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ["tmp"]


    # Configuration to be run (and then tested).
    lorax:
      fixture:
        files: "tmp/fixture.md"

    coffee:
      src:
        files:
          "tasks/lorax.js": "src/lorax.coffee"

    # Unit tests.
    nodeunit:
      tests: ["test/*_test.coffee"]

    watch:
      src:
        files: "src/lorax.coffee"
        tasks: ["coffeelint", "coffee"]

  grunt.registerTask "fileCheck", ->
    if grunt.file.exists "tmp/fixture.md"
      grunt.log.ok()
    else
      grunt.fail.fatal "Missing changelog"

  # Actually load this plugin's task(s).
  grunt.loadTasks "tasks"

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-nodeunit"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"

  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask "test", ["clean", "coffee", "lorax", "fileCheck"]

  # By default, lint and run all tests.
  grunt.registerTask "default", ["coffeelint", "test"]