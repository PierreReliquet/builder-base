FROM centos:7

RUN yum install -y unzip \
  which \
  make \
  wget \
  zip

# Git
RUN curl -o ./endpoint-repo-1.7-1.x86_64.rpm https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm && \
  rpm -Uvh endpoint-repo*rpm && \
  yum install -y git 

# Docker
ENV DOCKER_VERSION 17.12.0
RUN curl https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION-ce.tgz | tar xvz && \
  mv docker/docker /usr/bin/ && \
  rm -rf docker

# helm
ENV HELM_VERSION 2.7.2
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz  | tar xzv && \
  mv linux-amd64/helm /usr/bin/ && \
  rm -rf linux-amd64

# jx-release-version
ENV JX_RELEASE_VERSION 1.0.7
RUN curl -o ./jx-release-version -L https://github.com/jenkins-x/jx-release-version/releases/download/v${JX_RELEASE_VERSION}/jx-release-version-linux && \
  mv jx-release-version /usr/bin/ && \
  chmod +x /usr/bin/jx-release-version

# jx
ENV JX_VERSION 1.0.26
RUN curl -L https://github.com/jenkins-x/jx/releases/download/v${JX_VERSION}/jx-linux-amd64.tar.gz | tar xzv && \
  mv jx /usr/bin/

# updatebot
ENV UPDATEBOT_VERSION 1.1.0
RUN curl -o ./updatebot -L https://oss.sonatype.org/content/groups/public/io/jenkins/updatebot/updatebot/${UPDATEBOT_VERSION}/updatebot-${UPDATEBOT_VERSION}.jar && \
chmod +x updatebot && \
cp updatebot /usr/bin/ && \
rm -rf updatebot

# exposecontroller
ENV EXPOSECONTROLLER_VERSION 2.3.34
RUN curl -L https://github.com/fabric8io/exposecontroller/releases/download/v$EXPOSECONTROLLER_VERSION/exposecontroller-linux-amd64 > exposecontroller && \
  chmod +x exposecontroller && \
  mv exposecontroller /usr/bin/

# USER jenkins
WORKDIR /home/jenkins

CMD ["helm","version"]
