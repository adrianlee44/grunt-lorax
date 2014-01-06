# grunt-lorax [![Build Status](https://travis-ci.org/adrianlee44/grunt-lorax.png?branch=master)](https://travis-ci.org/adrianlee44/grunt-lorax)

> Grunt task for Lorax

## Getting Started
This plugin requires Grunt `~0.4.1`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-lorax --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-lorax');
```

## Lorax task

### Overview
In your project's Gruntfile, add a section named `lorax` to the data object passed into `grunt.initConfig()`.

```js
grunt.initConfig({
  lorax: {
    options: {
      // Task-specific options go here.
    },
    files: "",
  },
})
```

### Options

#### options.url
Type: `String`
Default value: ""

URL to project repository

#### options.type
Type: `String`
Default value: "^fix|^feature|^refactor|BREAKING"

Regular expression to match git commits

#### options.issue
Type: `String`
Default value: "/issues/%s"

URL template to specific issue

#### options.commit
Type: `String`
Default value: "/commit/%s"

URL template to specific commit

#### options.display
Type: `Object`
Default value: {
  fix: "Bug Fixes",
  feature: "Features",
  breaking: "Breaking Changes",
  refactor: "Optimizations"
}

Display text for different commit type

### Usage Examples

#### Basic option
```js
grunt.initConfig({
  lorax: {
    options: {
      url: "https://github.com/adrianlee44/grunt-lorax"
    },
    files: "changelog.md",
  },
})
```
