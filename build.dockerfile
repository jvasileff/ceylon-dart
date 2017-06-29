FROM openjdk:7-jdk-alpine

# Make wget work on the openjdk:7-jdk-alpine image
RUN apk --no-cache add openssl

# Install Ceylon 1.3.2
WORKDIR /ceylon
RUN wget --quiet --output-document=/tmp/ceylon.zip \
        "http://ceylon-lang.org/download/dist/1_3_2" \
    && unzip -q /tmp/ceylon.zip
ENV PATH /ceylon/ceylon-1.3.2/bin:$PATH
ENV CEYLON_HOME /ceylon/ceylon-1.3.2

# Download gradle
WORKDIR /deps
ADD build.gradle settings.gradle gradlew ./
ADD gradle gradle
RUN ./gradlew --no-daemon --status

