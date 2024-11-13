# Prepare the base environment.
FROM ubuntu:22.04 as builder_base_docker
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV PRODUCTION_EMAIL=True
ENV SECRET_KEY="ThisisNotRealKey"
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y  wget git nginx certbot python3-certbot-nginx 
RUN apt-get install --no-install-recommends -y  vim nano apache2-utils htop net-tools ssh

# Install Python libs from requirements.txt.
FROM builder_base_docker as python_libs_docker
WORKDIR /app
# Install the project (ensure that frontend projects have been built prior to this step).
FROM python_libs_docker
COPY boot.sh /
COPY sites.conf /etc/nginx/sites-enabled/
RUN chmod 755 /boot.sh
EXPOSE 80
HEALTHCHECK --interval=5s --timeout=2s CMD ["wget", "-q", "-O", "-", "http://localhost:80/"]
CMD ["/boot.sh"]
