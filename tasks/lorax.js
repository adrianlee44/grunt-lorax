(function() {
  module.exports = function(grunt) {
    return grunt.registerMultiTask("lorax", "Grunt task to generate changelog with git log", function() {
      var dest, done, files, lorax, options, path;
      path = require("path");
      lorax = require("lorax");
      options = this.options({
        type: "^fix|^feature|^refactor|BREAKING",
        tag: function() {
          var pkg, tag;
          tag = "";
          if (grunt.file.exists("package.json")) {
            pkg = grunt.file.readJSON("package.json");
            tag = pkg.version;
          }
          return tag;
        }
      });
      done = this.async();
      files = this.data.files;
      if (typeof files === "string") {
        this.files = [
          {
            dest: files
          }
        ];
      }
      dest = this.files[0].dest;
      lorax.config.set(options);
      return lorax.get(options.type).then(function(commits) {
        var commit, orig, parsedCommits, result;
        parsedCommits = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = commits.length; _i < _len; _i++) {
            commit = commits[_i];
            if (commit) {
              _results.push(lorax.parseCommit(commit));
            }
          }
          return _results;
        })();
        grunt.log.ok("Parsed " + parsedCommits.length + " commit(s)");
        result = lorax.write(parsedCommits, options.tag());
        orig = grunt.file.exists(dest) ? grunt.file.read(dest) : "";
        result = result + orig;
        grunt.file.write(dest, result, {
          encoding: "utf-8"
        });
        grunt.log.ok("File \"" + dest + "\" created.");
        return done();
      }, function() {
        return grunt.fail.fatal("Failed to retrieve log");
      });
    });
  };

}).call(this);
