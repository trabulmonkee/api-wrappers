# API WRAPPERS RUBY #

## Description ##
API Wrappers for API testing to be used as a base utility file
inside a RUBY automation framework for RESTful based and/or simulated
browser based testing

# ********************** TODO ADD MORE DETAILS ********************** #
Install
ruby - https://www.ruby-lang.org/en/ 
Bundler - https://rubygems.org/gems/bundler

Install project dependecies
In a terminal change directory into repo location `cd ./rb`
`bundle install`

Run command 
For all test files, via rake: `rake test run_env=local parallel=true test_threads=5`
For individual test file, via ruby: `ruby path/to/test_file.rb --run_env=local --parallel=true --test_threads=5`

### LICENSE ###
(The MIT License)

Copyright (c) M. Millgate

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
