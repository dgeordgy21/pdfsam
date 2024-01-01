FROM kasmweb/core-ubuntu-focal:1.14.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########
RUN apt-get update && apt-get install -y default-jdk && rm -rf /var/lib/apt/lists/*

RUN wget -q -O /tmp/pdfsam.deb https://github.com/torakiki/pdfsam/releases/download/v5.2.0/pdfsam_5.2.0-1_amd64.deb \
  && dpkg -i /tmp/pdfsam.deb \
  && rm /tmp/pdfsam.deb

RUN echo "/usr/bin/desktop_ready && /opt/pdfsam-basic/bin/pdfsam-basic" > $STARTUPDIR/custom_startup.sh \
&& chmod +x $STARTUPDIR/custom_startup.sh

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
