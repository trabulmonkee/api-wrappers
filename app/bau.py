# -*- coding: utf-8 -*-

from flask import Flask, request, json
from werkzeug.exceptions import HTTPException
import traceback

# start app server via terminal ./app/
# FLASK_ENV=development DEBUG=true FLASK_APP=bau flask run
### https://github.com/pallets/flask/issues/4714
### 2023 flask --app bau --debug run --port 9876
#  * Serving Flask app 'bau' (lazy loading)
#  * Environment: development
#  * Debug mode: on
#  * Running on http://127.0.0.1:9876 (Press CTRL+C to quit)
#  * Restarting with stat
#  * Debugger is active!
#  * Debugger PIN: 799-871-964

# create the flask app (default name: bau)
app = Flask(__name__)

@app.errorhandler(Exception)
def handle_exception(e):
    if not hasattr(e, 'get_response'):
        log_message = json.dumps(
            {
                "name": e.__class__.__name__,
                "message": str(e),
                "traceback": traceback.format_exc()
            }
        )
        return log_message, 500
    response = e.get_response()
    response.data = json.dumps({
        "code": e.code,
        "name": e.name,
        "description": e.description,
    })
    response.content_type = "application/json"
    return response

@app.route("/", methods=['GET'])
def welcome():
    return (
        "<html>"
        "<head><title>API-WRAPPERS UI</title></head>"
        "<body>"
        "<h1>Welcome to the API-WRAPPERS UI</h1>"
        "<p>It is a space to be used as an example API testing framework.<br />"
        "Each endpoint simulates a different API request/response call/answer.<br />"
        "Each endpoint includes the "
        "<a href='https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/OPTIONS'>OPTIONS</a> request method.<br />"
        "Responses are content-type='application/json', except for the OPTIONS call the content-type='text/html'.</p>"
        "<h2>Available endpoints are:</h2>"
        "<ul>"
        "<li>/delete-me</li>"
        "<li>/get-me</li>"
        "<li>/head-me</li>"
        "<li>/patch-me</li>"
        "<li>/post-me</li>"
        "<li>/put-me</li>"
        "<li>/tea-me</li>"
        "</ul>"
        "<p><strong>ENJOY!</strong></p>"
        "</body>"
        "</html>"
    )

@app.route("/delete-me", methods=['DELETE'])
def deleteMe():
    return {"message": "deleted"}, 202

@app.route("/get-me", methods=['GET'])
def getMe():
    return {"message": "got"}, 200

@app.route("/head-me", methods=['HEAD'])
def headMe():
    return {"message": "headed"}, 200

@app.route("/patch-me", methods=['PATCH'])
def patchMe():
    return {"message": "patched"}, 200

@app.route("/post-me", methods=['POST'])
def postMe():
    return {"message": "posted"}, 200

@app.route("/put-me", methods=['PUT'])
def putMe():
    return {"message": "put"}, 200

@app.route("/tea-me", methods=['GET'])
def teaMe():
    return {"message": "delightful"}, 418

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9876) # debug=True)
