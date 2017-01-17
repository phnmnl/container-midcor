# PhenoMeNal H2020
FROM r-base:3.3.1

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL software.version="1.0"
LABEL version="0.1"
ENV MIDCOR_REVISION "8559ced39d6f9360fbc80c76e44b7c3ca8f10b1e"

RUN apt-get -y update && apt-get install -y --no-install-recommends libcurl4-openssl-dev libssl-dev git

# Add scripts folder to container
ADD scripts/runMidcor.R /usr/bin/runMidcor.R
ADD scripts/runTest1.sh /usr/bin/runTest1.sh
RUN chmod +x /usr/bin/runTest1.sh
# Add automatic repo finder for R:
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /etc/R/Rprofile.site


# Install midcor
RUN echo 'install.packages("devtools")' > install_midcor.R
RUN echo 'install.packages("optparse")' >> install_midcor.R
RUN echo 'library(devtools)' >> install_midcor.R
RUN echo 'install_github("seliv55/midcor", ref=Sys.getenv("MIDCOR_REVISION")[1])' >> install_midcor.R

RUN Rscript install_midcor.R

# Clean up
RUN apt-get clean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

RUN chmod +x /usr/bin/runMidcor.R
# Define Entry point script
ENTRYPOINT ["runMidcor.R"]
