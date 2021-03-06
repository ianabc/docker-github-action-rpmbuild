FROM centos:7

LABEL maintainer="Ian Allison <iana@pims.math.ca>"

WORKDIR /github/workspace

RUN yum install -y epel-release && \
    yum install -y rpmdevtools yum-utils spectool make gcc && \
    yum clean all && \
    rm -r -f /var/cache/*

CMD spectool --get-files --all SPECS/*.spec && \
    yum-builddep --assumeyes SPECS/*.spec && \
    rpmbuild --define '_topdir /github/workspace' -ba SPECS/*.spec

