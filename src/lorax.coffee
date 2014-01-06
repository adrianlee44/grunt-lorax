#
# @chalk overview
# @name grunt-lorax
# @url https://github.com/adrianlee44/grunt-lorax
#
# @copyright Copyright (c) 2014 Adrian Lee
# @license Licensed under the MIT license.
#

module.exports = (grunt) ->

  grunt.registerMultiTask "lorax", "Grunt task to generate changelog with git log", ->
    path  = require "path"
    lorax = require "lorax"

    options = @options
      type: "^fix|^feature|^refactor|BREAKING"
      tag:  ->
        tag = ""
        if grunt.file.exists "package.json"
          pkg = grunt.file.readJSON "package.json"
          tag = pkg.version

        return tag

    done   = @async()
    files  = @data.files
    @files = [{dest: files}] if typeof files is "string"
    dest   = @files[0].dest

    lorax.config.set options

    lorax.get(options.type).then (commits) ->
      parsedCommits = (lorax.parseCommit commit for commit in commits when commit)

      grunt.log.ok "Parsed #{parsedCommits.length} commit(s)"

      result = lorax.write parsedCommits, options.tag()

      # Append to original document
      orig   = if grunt.file.exists dest then grunt.file.read dest else ""
      result = result + orig

      grunt.file.write dest, result, encoding: "utf-8"

      grunt.log.ok "File \"#{dest}\" created."
      done()
    , ->
      grunt.fail.fatal "Failed to retrieve log"
