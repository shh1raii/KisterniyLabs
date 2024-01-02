# Use the official Jenkins master image
FROM jenkins/jenkins:2.361.1-lts-centos7

USER root

# Install Docker dependencies
RUN yum install -y yum-utils \
    && yum-config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker
RUN yum install -y docker-ce docker-ce-cli containerd.io
RUN dockerd &
COPY .docker/Dockerfile /var/jenkins_home/

# Switch to the Jenkins user
USER jenkins

# Set environment variables for Jenkins setup
ENV JENKINS_USER admin
ENV JENKINS_PASS admin
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Copy the Jenkins plugins file to the container
RUN jenkins-plugin-cli --plugins workflow-aggregator

# Copy job configuration files to the container
COPY jobs/ /usr/share/jenkins/ref/jobs/

# Set the ownership of copied files to the Jenkins user
USER root
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/jobs/
RUN chown -R jenkins:jenkins /var/lib/rpm

# Expose ports for web UI and agent communication
EXPOSE 8080
EXPOSE 50000

# Command to start Jenkins master
CMD ["/usr/local/bin/jenkins.sh"]
