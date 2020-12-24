FROM ubuntu:latest
MAINTAINER diwakarajay44@gmail.com
RUN apt install -y apache2 && \
    apt install -y unzip
#RUN git clone https://github.com/Ajaydiwakar/transparent_login.git
ADD https://www.free-css.com/assets/files/free-css-templates/download/page261/parallo.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip parallo.zip && \
    cp -rvf templatemo_534_parallo/*  .   && \
    rm -Rf templatemo_534_parallo parallo.zip
CMD [*/usr/sbin/httpd", "-D" , "FOREGROUND"]
EXPOSE 80

