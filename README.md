# Griddler::Cloudmailin
[![Gem Version](https://badge.fury.io/rb/griddler-cloudmailin.svg)](https://rubygems.org/gems/griddler-cloudmailin)
[![Gem downloads](https://img.shields.io/gem/dt/griddler-cloudmailin.svg)](https://rubygems.org/gems/griddler-cloudmailin)
[![Code quality](http://img.shields.io/codeclimate/github/thoughtbot/griddler-cloudmailin.svg?style=flat)](https://codeclimate.com/github/thoughtbot/griddler-cloudmailin)
[![Dependency Status](https://gemnasium.com/badges/github.com/thoughtbot/griddler-cloudmailin.svg)](https://gemnasium.com/github.com/thoughtbot/griddler-cloudmailin)
[![Security](https://hakiri.io/github/thoughtbot/griddler-cloudmailin/master.svg)](https://hakiri.io/github/thoughtbot/griddler-cloudmailin/master)
[![Build status](https://img.shields.io/travis/thoughtbot/griddler-cloudmailin/master.svg)](https://travis-ci.org/thoughtbot/griddler-cloudmailin)
[![Coverage Status](https://coveralls.io/repos/github/thoughtbot/griddler-cloudmailin/badge.svg?branch=develop)](https://coveralls.io/github/thoughtbot/griddler-cloudmailin?branch=develop)

An adapter for [Griddler](https://github.com/thoughtbot/griddler) to allow
[Cloudmailin](http://cloudmailin.com) to be used with the gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'griddler-cloudmailin'
```

## Usage

See the [Griddler](https://github.com/thoughtbot/griddler) gem for usage instructions

## Upgrading from version 0.0.1

Griddler::Cloudmailin now includes all details of the recipients of the email in the `to` array of a `Griddler::Email`
object. In version 0.0.1 this method returned the bare address of the Cloudmailin recipient only.

The email `date` is now returned as well.

There is an additional `bcc` array which contains the Cloudmailin recipient if it was BCCed on the email.

Attachments are now returned in the `attachments` array.

## More Information

* [Griddler](https://github.com/thoughtbot/griddler)
* [Cloudmailin documentation](http://docs.cloudmailin.com/)
