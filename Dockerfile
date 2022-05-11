# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y clang libncursesw5 libncursesw5-dev

## Add source code to the build stage.
ADD . /happygrep
WORKDIR /happygrep

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
WORKDIR /happygrep
RUN clang happygrep.c -fsanitize=fuzzer -lncursesw -o happygrep

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /happygrep/happygrep /
