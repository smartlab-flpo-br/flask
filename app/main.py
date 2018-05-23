from flask import Flask
application = Flask(__name__)

@application.route("/")
def hello():
    return "<html>Smartlab's Flask</html>"

if __name__ == "__main__":
    application.run(h)
