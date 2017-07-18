# PhenoMeNal H2020
FROM container-registry.phenomenal-h2020.eu/phnmnl/rbase:v3.4.1-1xenial0_cv0.2.12

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL software.version="1.0"
LABEL version="0.3"
LABEL software="MIDcor"
LABEL description="Corrects 13C mass isotopomers spectra of metabolites for natural occurring isotopes and peaks overlapping."
LABEL website="https://github.com/seliv55/midcor"
LABEL documentation="https://github.com/phnmnl/container-midcor/blob/master/README.md"
LABEL license="https://github.com/phnmnl/container-midcor/blob/develop/License.txt"
LABEL tags="Metabolomics"

ENV MIDCOR_REVISION "e59b9c46244de68f6bf48e4c31651ebf20022206"

# Setup package repos
RUN apt-get -y update && apt-get -y --no-install-recommends install r-base-dev libssl-dev \
                                    libcurl4-openssl-dev git \
                                    libssh2-1-dev && \
    echo 'options("repos"="https://cran.rediris.es/")' >> /etc/R/Rprofile.site && \
    R -e "install.packages(c('devtools', 'optparse'))" && \
    R -e 'library(devtools); install_github("seliv55/midcor",ref=Sys.getenv("MIDCOR_REVISION")[1])' && \
    R -e "remove.packages(c('devtools'))" && \
    apt-get purge -y git r-base-dev libssl-dev libcurl4-openssl-dev libssh2-1-dev && \
    apt-get clean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Add scripts folder to container
ADD scripts/runMidcor.R /usr/bin/runMidcor.R
ADD scripts/runTest1.sh /usr/bin/runTest1.sh
ADD scripts/runTest2.sh /usr/bin/runTest2.sh
RUN chmod +x /usr/bin/runTest1.sh
RUN chmod +x /usr/bin/runMidcor.R
RUN chmod +x /usr/bin/runTest2.sh
# Define Entry point script
ENTRYPOINT ["runMidcor.R"]
