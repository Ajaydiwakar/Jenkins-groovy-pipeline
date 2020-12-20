FROM centos:latest
MAINTAINER diwakarajay44@gmail.com
RUN yum install -y httpd \
    zip \
    unzip \
#RUN git clone https://github.com/Ajaydiwakar/transparent_login.git
ADD https://www.free-css.com/assets/files/free-css-templates/download/page261/parallo.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip parallo.zip
RUN cp -rvf templatemo_534_parallo/* .
RUN rm -rf templatemo_534_parallo parallo.zip
CMD [*/usr/sbin/httpd", "-D" , "FOREGROUND"]
EXPOSE 80
