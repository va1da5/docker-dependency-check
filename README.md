
# Dependency Checker with Docker

Drop-in bash script to check for vulnerable dependencies. The script is based on [Dependency-Check](https://hub.docker.com/r/owasp/dependency-check) Docker image. More information about the project can be found [here](https://jeremylong.github.io/DependencyCheck/).

## Requirements

- Docker
- Internet connection to pull `owasp/dependency-check:latest` image

## Usage
- Copy-paste `run.sh` to project's root directory
- Make it executable with `chmod +x run.sh`
- Run the script `./run.sh`
- Inspect generate report in `report` directory
- Update the project dependencies :)

*Please note that the first run might take up to 20 minutes, because it fetches data from National Vulnerability Database.*

