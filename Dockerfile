# PhenoMeNal H2020
FROM ubuntu:16.04

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL software.version="1.0"
LABEL version="0.2"
LABEL software=MIDcor

ENV MIDCOR_REVISION "f78167573303b97ae9fb1849549965fc6ba53fac"

# Setup package repos
RUN echo "deb http://cloud.r-project.org/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

RUN apt-get -y update && apt-get -y --no-install-recommends install r-base r-base-dev libssl-dev \
                                    libcurl4-openssl-dev git \
                                    libssh2-1-dev && \
    echo 'options("repos"="http://cran.rstudio.com")' >> /etc/R/Rprofile.site && \
    R -e "install.packages(c('devtools', 'optparse'))" && \
    R -e 'library(devtools); install_github("seliv55/midcor",ref=Sys.getenv("MIDCOR_REVISION")[1])' && \
    R -e "remove.packages(c('devtools'))" && \
    apt-get purge -y git r-base-dev libssl-dev libcurl4-openssl-dev libssh2-1-dev && \
    apt-get clean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Add scripts folder to container
ADD scripts/runMidcor.R /usr/bin/runMidcor.R
ADD scripts/runTest1.sh /usr/bin/runTest1.sh
RUN chmod +x /usr/bin/runTest1.sh
RUN chmod +x /usr/bin/runMidcor.R
# Define Entry point script
ENTRYPOINT ["runMidcor.R"]
