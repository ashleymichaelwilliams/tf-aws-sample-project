#########################################################
###         Homebrew Scratch Container Image          ###
#########################################################

FROM homebrew/brew AS homebrew-scratch

# Install tfenv utility
RUN brew install tfenv





###########################################################
###         Deployable Artifact Container Image         ###
###########################################################

FROM alpine:3.11

ARG NON_ROOT_USER=alpine
ARG NON_ROOT_USER_HOME=/home/${NON_ROOT_USER}

# Create a Non-Root User
RUN addgroup -g 1000 ${NON_ROOT_USER} && \
    adduser -D -s '/bin/bash' -h ${NON_ROOT_USER_HOME} -u 1000 -G ${NON_ROOT_USER} ${NON_ROOT_USER}



# Download/Install Package Dependencies
RUN apk update && \
    apk upgrade && \
    apk add jq unzip bash curl && \
    apk add --no-cache --update python3 ### Install Python3 Runtime && \
    rm -rf /var/cache/apk/* ### Cleanup Package Manager Cache

# Install HCL Command-line Parsing Tool (pyhcl)
RUN pip3 install pyhcl --no-cache-dir

# Copy Binaries from Scratch Images
COPY --from=homebrew-scratch --chown=${NON_ROOT_USER} /home/linuxbrew/.linuxbrew/opt/tfenv ${NON_ROOT_USER_HOME}/.tfenv



# Stage Project Files in Container Filesystem
COPY --chown=${NON_ROOT_USER} docker-entrypoint.sh /docker-entrypoint.sh

# Set File Permissions
RUN chmod 755 /docker-entrypoint.sh

# Terraform Resource Module Files
COPY --chown=${NON_ROOT_USER} . /terraform-module/



# Switch to Non-Root User
USER ${NON_ROOT_USER}
WORKDIR ${NON_ROOT_USER_HOME}

# Set Environment Path and Shell
ENV PATH=${NON_ROOT_USER_HOME}/.tfenv/bin:$PATH
ENV SHELL=/bin/bash



# ##### Start Container #####
ENTRYPOINT ["/docker-entrypoint.sh"]
