# Summary Generator

[![Build Status](https://magnum.travis-ci.com/guidance-guarantee-programme/pdf_output.svg?token=Na2Zajdrgs8wscyzQfn2)](https://magnum.travis-ci.com/guidance-guarantee-programme/pdf_output)

Generate [Pension Wise] summary documents in PDF format only.


## Prerequisites

* [Bundler]
* [Git]
* [Node.js][Node]
* [PrinceXML]
* [NPM]
* [Ruby 2.2.3][Ruby]


## Installation

Clone the repository:

```sh
$ git clone https://github.com/guidance-guarantee-programme/summary_generator.git
```

Setup the application:

```sh
$ ./bin/setup
```

Download and install PrinceXML, and make sure it is available on the path. Generated PDFs will
have a PrinceXML watermark unless you install a valid PrinceXML licence.

Details on the [PrinceXML website][princexml].

## Usage

To start the application:

```sh
$ ./bin/foreman s -p <port>
```

where <port> is the port you'd like the application to listen on.

### Production-mode

To run the application in "production" mode, the following environment variables need to be set:

* `RAILS_ENV=production`
* `SECRET_KEY_BASE=<some secret token>`

## Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)


## Contributing

Please see the [contributing guidelines](/CONTRIBUTING.md).

[bundler]: http://bundler.io
[git]: http://git-scm.com
[heroku]: https://www.heroku.com
[node]: http://nodejs.org
[npm]: https://www.npmjs.org
[pension wise]: https://www.pensionwise.gov.uk
[princexml]: http://www.princexml.com/
[ruby]: http://www.ruby-lang.org/en
