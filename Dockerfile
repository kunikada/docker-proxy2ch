FROM alpine

RUN apk add --update-cache --no-cache alpine-sdk curl-dev

RUN curl -L -O https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.17.tar.gz \
  && tar zxf libiconv-1.17.tar.gz && rm libiconv-1.17.tar.gz \
  && cd libiconv-1.17 \
  && ./configure && make && make install \
  && cd .. && rm -r libiconv-1.17

RUN curl -L -O https://notabug.org/NanashiNoGombe/proxy2ch/archive/master.tar.gz \
  && tar xzf master.tar.gz && rm master.tar.gz \
  && cd proxy2ch \
  && make \
  && mv proxy2ch /usr/local/bin \
  && cd .. && rm -r proxy2ch

RUN adduser -D proxy2ch
WORKDIR /home/proxy2ch
USER proxy2ch

EXPOSE 9080

ENTRYPOINT ["/usr/local/bin/proxy2ch"]
CMD ["--help"]
