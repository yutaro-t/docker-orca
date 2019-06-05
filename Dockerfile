FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i s/archive.ubuntu.com/linux.yz.yamagata-u.ac.jp/g /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y wget tar apt-utils gnupg

RUN wget -q https://ftp.orca.med.or.jp/pub/ubuntu/archive.key
RUN wget -q -O /etc/apt/sources.list.d/jma-receipt-bionic51.list https://ftp.orca.med.or.jp/pub/ubuntu/jma-receipt-bionic51.list -P /etc/apt/sources.list.d
RUN apt-key add archive.key
RUN apt-get update
RUN apt-get dist-upgrade -y

RUN apt-get install -y panda-client2 jma-receipt
RUN wget http://ftp.orca.med.or.jp/pub/etc/install_modules_for_ftp.tgz
RUN tar xvzf install_modules_for_ftp.tgz
RUN cd install_modules_for_ftp
RUN ./install_modules.sh
RUN jma-setup
RUN service jma-receipt start
RUN service jma-receipt stop
RUN service jma-receipt start
RUN /usr/lib/jma-receipt/bin/passwd_store.sh
