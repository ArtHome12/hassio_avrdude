ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Artem Khomenko
LABEL maintainer="_mag12@yahoo.com"

# For parse options
RUN apk add --no-cache jq

# Install AVRDude
RUN apk --no-cache add bash avrdude

# For any preinstalled .hex
COPY *.hex /

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
