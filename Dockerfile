# Container image that runs your code
FROM ubuntu:16.04
FROM php:7.2.34-alpine
RUN cat /etc/*-release
EXPOSE 80
