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

## Project 13: AWS CodeBuild and ECR

`buildspec.yml` builds this image and pushes `latest` to the private ECR repository `project13-app` in the CodeBuild project's AWS account and region. Create that repository first, and use an approved CodeBuild Linux environment with Docker support (privileged mode where required). Configure the project's source to this GitHub branch and its buildspec to `buildspec.yml`.

The CodeBuild service role needs permission to authenticate to ECR (`ecr:GetAuthorizationToken`), push to the repository (`ecr:BatchCheckLayerAvailability`, `ecr:InitiateLayerUpload`, `ecr:UploadLayerPart`, `ecr:CompleteLayerUpload`, and `ecr:PutImage`), and write build logs. Use the instructor's approved role and avoid putting AWS credentials in the repository. Builds and ECR storage may incur AWS charges.
