FROM alpine:3.22

RUN apk add --no-cache dnsmasq bind-tools curl
COPY dnsmasq.conf /etc/dnsmasq.conf

EXPOSE 1053/udp 1053/tcp
CMD ["dnsmasq", "--no-daemon", "--log-facility=-"]
