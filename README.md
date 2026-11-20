# Project 8: Build and Run Docker App Locally

This static web app is served by Python's built-in HTTP server inside a small Docker image. The container runs as a non-root user and has no external runtime dependencies.

## Build and run

```sh
docker build -t project8-app .
docker run --rm -p 8080:8000 --name project8-app project8-app
```

Open [http://localhost:8080](http://localhost:8080). Press `Ctrl+C` to stop the container.

## Screenshot

See `screenshot.png` for the app running from the container.
