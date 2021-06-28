FROM jitteam/devicequery:latest

COPY output/jetson-devicequery /usr/local/bin
CMD ["/usr/local/bin/jetson-devicequery"]