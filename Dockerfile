FROM centos:centos6.6

MAINTAINER KazukiTanaka <c304521@gmail.com>

# Install Devlib
RUN yum update -y
RUN yum install -y git tar bzip2 zlib gcc gcc-c++ make

# Install plenv
RUN git clone git://github.com/tokuhirom/plenv.git /usr/share/plenv
RUN git clone git://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build
ENV PATH ${PATH}:/usr/share/plenv/bin

# Install perl 5.18.x
RUN plenv install 5.18.2 -Dusethreads
RUN plenv global 5.18.2

# Install cpanm and carton
RUN plenv install-cpanm
RUN plenv rehash
RUN plenv exec cpanm Carton
