FROM jeanblanchard/busybox-java:java7

ENV ES_PKG_NAME elasticsearch-1.5.0

# Install ElasticSearch.
RUN wget --no-check-certificate http://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz -O /tmp/elasticsearch.tar.gz
RUN gunzip /tmp/elasticsearch.tar.gz && tar xvf /tmp/elasticsearch.tar -C /opt && mv /opt/$ES_PKG_NAME /elasticsearch && rm -rf /tmp/elasticsearch.tar

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

WORKDIR /elasticsearch
RUN bin/plugin -install elasticsearch/elasticsearch-cloud-aws/2.5.0

ENTRYPOINT ["/elasticsearch/bin/elasticsearch"]
