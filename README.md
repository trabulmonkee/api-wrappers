# API WRAPPERS #

## Description ##
API Wrappers for API testing to be used as a base utility file
inside an automation framework for RESTful based and/or simulated
browser based testing.

See individual language folders for additional language README details
- [app](app/README.md) - Python Flask app serving as the API Backend.
- go ** TODO ** - API Wrappers example usage via Go.
- java ** TODO ** - API Wrappers example usage via Java.
- javascript ** TODO ** - API Wrappers example usage via JavaScript.
- [python](py/README.md) - API Wrappers example usage via Python.
- [ruby](rb/README.md) - API Wrappers example usage via Ruby.
- rust ** TODO ** - API Wrappers example usage via Rust.

### DOCKER ###

This project uses docker as way to standardize the environment and the base application used for testing purposes.  Make sure to have [docker installed](https://www.docker.com/get-started/) on your machine first.

Then navigate to the root directory of the project on your local machine in a terminal.

Execute: `docker compose up --detach` this will build a local image if one does not already exist, of the base python flask app and then using that image creates a container locally on your machine with the flask app running in detached mode.

Navigate to `http://localhost:9876/` in a browser to confirm app is running via the docker container and see additional details.

Use `docker compose down` to turn off/bring down the container when it is no longer needed.

Enjoy!

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
