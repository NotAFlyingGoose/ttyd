FROM ubuntu:20.04

WORKDIR /app

# Dependencies
RUN apt-get update
RUN apt-get install -y build-essential cmake git libjson-c-dev libwebsockets-dev
RUN git clone https://github.com/tsl0922/ttyd.git
RUN cd ttyd && mkdir build && cd build
RUN cmake ..
RUN make && make install

# Application

COPY . .

EXPOSE 443

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["ttyd", "-W", "--ssl", "--port", "443", "bash"]
