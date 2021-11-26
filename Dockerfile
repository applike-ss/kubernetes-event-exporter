FROM golang:1.17 AS builder

ADD . /app
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=linux GO11MODULE=on go build -mod=vendor -a -o /main .

FROM docker.io/bitnami/kubernetes-event-exporter:0.11.0-debian-10-r0
COPY --from=builder /main /opt/bitnami/kubernetes-event-exporter/bin/kubernetes-event-exporter
