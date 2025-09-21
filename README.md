<img alt="icon" src=".diploi/icon.svg" width="32">

# Flask Component for Diploi

[![launch with diploi badge](https://diploi.com/launch.svg)](https://diploi.com/component/flask)
[![component on diploi badge](https://diploi.com/component.svg)](https://diploi.com/component/flask)
[![latest tag badge](https://badgen.net/github/tag/diploi/component-flask)](https://diploi.com/component/flask)

## Operation

### Getting started

1. In the Dashboard, click **Create Project +**
2. Under **Pick Components**, choose **Flask**. Here you can also add a frontend framework to create a monorepo app, eg, Flask for backend and React+Vite for frontend
3. In **Pick Add-ons**, you can add one or multiple databases to your app
4. Choose **Create Repository** to generate a new GitHub repo
5. Finally, click **Launch Stack**

### Development

During development, the container installs Node.js and `nodemon` to enable automatic reloads when files change. The development server is started with:

```sh
nodemon --delay 1 --watch "pyproject.toml" --watch ".venv/lib/*" --watch ".venv/lib64/*" --watch "src"  --ext "py" --exec "uv run --isolated flask --app src/main.py run --host=0.0.0.0 --port=8000 --no-reload --debug"
```

This will:
- Activate the virtual environment in `.venv`
- This runs the Flask app defined in main.py using the uv tool in an isolated environment, making the app available on all network interfaces at port 8000, with debug mode enabled.

### Production

Builds a production-ready image. During the build, dependencies are installed with `uv sync`. When the container starts, it runs:

```sh
uv run --frozen gunicorn -w 4 -b 0.0.0.0:8000 src.main:app
```

This uses the Gunicorn to serve your application on port 8000.


## Links

- [Flask documentation](https://flask.palletsprojects.com/en/stable/)
- [Python documentation](https://docs.python.org/)
- [uv documentation](https://docs.astral.sh/uv/)