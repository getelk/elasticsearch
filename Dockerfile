FROM gliderlabs/alpine:latest

ENV ES_PKG_NAME elasticsearch-1.4.4

# Install java
RUN \
  apk update && \
  apk add openjdk7-jre-base && \
  apk add wget

# Install ElasticSearch.
RUN \
  cd / && \
  wget --no-check-certificate https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
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
