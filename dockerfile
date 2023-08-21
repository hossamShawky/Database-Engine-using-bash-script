FROM alpine:latest

RUN apk update && apk add --no-cache bash

COPY ./* /scripts
WORKDIR /scripts

ENTRYPOINT [ "bash" ,"main_menu.sh" ]
