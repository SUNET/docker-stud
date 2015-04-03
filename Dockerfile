FROM ubuntu
MAINTAINER leifj@sunet.se
RUN apt-get -y update
RUN apt-get install -y build-essential libssl-dev libz-dev ssl-cert git-core
RUN apt-get install -y libev-dev
RUN git clone https://github.com/axsh/stud.git
RUN cd stud && make && make install
ADD start.sh /start.sh
RUN chmod a+rx /start.sh
VOLUME /etc/ssl
ENV HTTP_PORT 80
ENV CORES 1
ENV CIPHERS ECDHE-RSA-AES128-SHA256:AES128-GCM-SHA256:RC4:HIGH:!MD5:!aNULL:!EDH
ENTRYPOINT ["/start.sh"]
EXPOSE 443
