FROM balenalib/raspberrypi3-debian-node:10.10-stretch-build as build

RUN apt-get update
RUN apt-get install libasound2 libxtst6

RUN wget https://github.com/bell-sw/Liberica/releases/download/11.0.2/bellsoft-jdk11.0.2-linux-arm32-vfp-hflt.deb
RUN apt-get install ./bellsoft-jdk11.0.2-linux-arm32-vfp-hflt.deb

RUN update-alternatives --config javac
RUN update-alternatives --config java

ENV JENKINS_HOME /usr/local/jenkins

RUN mkdir -p /usr/local/jenkins
RUN useradd --no-create-home --shell /bin/sh jenkins 
RUN chown -R jenkins:jenkins /usr/local/jenkins/
ADD http://mirrors.jenkins-ci.org/war-stable/latest/jenkins.war /usr/local/jenkins.war
RUN chmod 644 /usr/local/jenkins.war


ENTRYPOINT ["/usr/bin/java", "-jar", "/usr/local/jenkins.war"]
EXPOSE 8080
CMD [""]
