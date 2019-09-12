# Dockerfile References: https://docs.docker.com/engine/reference/builder/

# Start from the latest golang base image
FROM golang:latest

# Add Maintainer Info
LABEL maintainer="Hakob Arakelyan <hakoaraqelyan@gmail.com>"

# Set the Current Working Directory inside the container
WORKDIR /app

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN eval $(go env)

RUN go get github.com/prometheus/client_golang/prometheus 
RUN go get github.com/prometheus/client_golang/prometheus/promhttp 
RUN go get github.com/prometheus/client_golang/prometheus/promauto
RUN go get github.com/sirupsen/logrus

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN cd src/api && go build -o main .

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["src/api/main"]


