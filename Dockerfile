#FROM python:3.4.6
FROM ubuntu:18.04

ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y apt-transport-https curl gnupg
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

RUN apt-get update && apt-get install -y python3-dev python3-pip mysql-server libmysqlclient-dev libxml2-dev libxslt1-dev wget kubectl
RUN python3 -V

# SYSTEM ACTIONS
WORKDIR /etc

ADD ./requirements.txt /etc/requirements.txt
ADD ./requirements_junoleaf.txt /etc/requirements_junoleaf.txt
ADD ./requirements_inspectologist.txt /etc/requirements_inspectologist.txt
RUN pip3 install -r requirements.txt

#RUN python3 -m nltk.downloader all
#RUN python3 -m spacy download en

RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

WORKDIR /opt/junoleaf

RUN apt-get install -y mysql-server pv

