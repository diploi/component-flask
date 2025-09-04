from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_diploi():
    return "🎊 Welcome to " + "<a href='https://diploi.com'>diploi.com</a>"