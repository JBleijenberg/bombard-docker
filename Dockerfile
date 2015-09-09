FROM debian:jessie

RUN apt-get update && apt-get install -qq -y \
	libgd-graph-perl \
	wget \
	build-essential \
	siege \
	git
RUN wget --no-verbose  http://www.cpan.org/authors/id/C/CH/CHARTGRP/Chart-2.4.6.tar.gz && tar zxf Chart-2.4.6.tar.gz && cd Chart-2.4.6 && perl Makefile.PL && make && make test && make install
RUN git clone https://github.com/allardhoeve/bombard.git && cd bombard && ./configure && make && make install

COPY .siegerc /root/.siegerc

CMD ["/usr/local/bin/bombard", "-f", "/data/test_urls.txt", "-i50", "-r10", "-s100", "-t10"]