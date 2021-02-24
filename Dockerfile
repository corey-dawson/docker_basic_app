FROM rocker/shiny:latest

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# install packages
#RUN R -e "install.packages(c('shiny'), repos='https://cloud.r-project.org/')"

# create application folder in image and move app code
WORKDIR /
RUN mkdir home/app
COPY /app/app.R /home/app

#set working directoring
WORKDIR /home/app

# expose port
EXPOSE 3838

# run app on container start
#if you did not set working directory to app directory, need to set in CMD
CMD ["R", "-e", "shiny::runApp(host = '0.0.0.0', port = 3838)"]