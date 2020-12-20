FROM centos:latest
MAINTAINER diwakarajay44@gmail.com
RUN yum install -y httpd \
    zip \
    unzip \
ADD https://www.free-css.com/assets/files/free-css-templates/download/page261/parallo.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip parallo.zip
RUN cp -rvf markups-parallo/* .
RUN rm -rf _MACOSX markups-parallo parallo.zip
CMD [*/usr/sbin/httpd", "-D" , "FOREGROUND"]
EXPOSE 80
