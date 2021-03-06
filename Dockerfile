FROM centos:7@sha256:fe2347002c630d5d61bf2f28f21246ad1c21cc6fd343e70b4cf1e5102f8711a9
ARG USER_ID=2000
# Rsyslog is more up to date on Centos that on Debian.
# In version 8.33.0 we can get som env variable in configuration
# https://www.rsyslog.com/doc/v8-stable/rainerscript/constant_strings.html

EXPOSE 5514/tcp 5514/udp

# Install utilities
RUN yum update -y && \
    yum install -y wget telnet && \
    wget -qO /etc/yum.repos.d/rsyslog.repo http://rpms.adiscon.com/v8-stable/rsyslog.repo && \
    yum install -y rsyslog

RUN rm -f /etc/rsyslog.d/*.conf
COPY rsyslog.conf /etc/
COPY conf.d/ /etc/rsyslog.d/
USER ${USER_ID}
ENTRYPOINT ["rsyslogd", "-n"]
