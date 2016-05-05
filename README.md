# Griddler::Cloudmailin

An adapter for [Griddler](https://github.com/thoughtbot/griddler) to allow
[Cloudmailin](http://cloudmailin.com) to be used with the gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'griddler'
gem 'griddler-cloudmailin'
```

## Usage

See the [Griddler](https://github.com/thoughtbot/griddler) gem for usage instructions

## Upgrading from version 0.0.1

Griddler::Cloudmailin now includes all details of the recipients of the email in the `to` array of a `Griddler::Email`
object. In version 0.0.1 this method returned the bare address of the Cloudmailin recipient only.

There is an additional `bcc` array which contains the Cloudmailin recipient if it was BCCed on the email.

Attachments are now returned in the `attachments` array.

## More Information

* [Griddler](https://github.com/thoughtbot/griddler)
* [Cloudmailin documentation](http://docs.cloudmailin.com/)
