# PDF Output

[![Build Status](https://travis-ci.org/guidance-guarantee-programme/pdf_output.svg)](https://travis-ci.org/guidance-guarantee-programme/pdf_output)

Generate [Pension Wise] appointment output in PDF format only.


## Prerequisites

* [Bundler]
* [Git]
* [Node.js][Node]
* [PrinceXML]
* [NPM]
* [Ruby 2.2.1][Ruby]


## Installation

Clone the repository:

```sh
$ git clone https://github.com/guidance-guarantee-programme/pdf_output.git
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
$ ./bin/foreman s
```

## Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)


## Contributing

Please see the [contributing guidelines](/CONTRIBUTING.md).

[bundler]: http://bundler.io
[git]: http://git-scm.com
[heroku]: https://www.heroku.com
[node]: http://nodejs.org
[npm]: https://www.npmjs.org
[pension wise]: https://www.gov.uk/pensionwise
[princexml]: http://www.princexml.com/
[ruby]: http://www.ruby-lang.org/en
