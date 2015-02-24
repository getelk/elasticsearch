FROM gliderlabs/alpine:latest

ENV ES_PKG_NAME elasticsearch-1.4.2

# Install java
RUN \
  apk update && \
  apk add openjdk7-jre-base

# Install ElasticSearch.
RUN \
  cd / && \
  wget http://s3.amazonaws.com/replicated-cdn/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD ./files/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

ENTRYPOINT ["/elasticsearch/bin/elasticsearch"]
