# PhenoMeNal H2020

FROM r-base:3.3.1

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

RUN apt-get -y update && apt-get -y --allow-downgrades install libssl-dev \
                                    libcurl4-openssl-dev=7.50.1-1 git \
                                    libssh2-1-dev

# Add scripts folder to container
ADD scripts/runMidcor.R /usr/bin/runMidcor.R

# Add automatic repo finder for R:
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /etc/R/Rprofile.site


# Install midcor
RUN echo 'install.packages("devtools")' > install_midcor.R
RUN echo 'install.packages("optparse")' >> install_midcor.R
RUN echo 'library(devtools)' >> install_midcor.R
RUN echo 'install_github("seliv55/midcor")' >> install_midcor.R

RUN Rscript install_midcor.R

# Clean up
RUN apt-get clean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

RUN chmod +x /usr/bin/runMidcor.R
# Define Entry point script
ENTRYPOINT ["runMidcor.R"]
