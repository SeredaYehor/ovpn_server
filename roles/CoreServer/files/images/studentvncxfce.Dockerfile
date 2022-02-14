FROM consol/ubuntu-xfce-vnc:latest

USER root

# Create student user

RUN useradd -ms /bin/bash student

# Install all for C++ and single jdk for java

RUN apt-get update
RUN apt-get install -y codeblocks g++ default-jdk default-jre unzip libreoffice nano mc

### Install netbeans

#RUN wget --no-check-certificate https://apache.volia.net/netbeans/netbeans/12.0/netbeans-12.0-bin.zip -O /tmp/netbeans.zip && echo "Done"
#RUN unzip /tmp/netbeans.zip -d /opt
RUN apt-get install -y netbeans

### Install eclipse

RUN apt-get install -y eclipse

### Install monodevelop (for C#)

RUN apt-get install -y apt-transport-https dirmngr
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu xenial main" | tee /etc/apt/sources.list.d/mono-official-vs.list
RUN apt-get update
RUN apt-get install -y monodevelop mono-complete

### Install python3 and pip3

RUN apt install -y python3 python3-pip

### Install lazarus

RUN apt-get install -y lazarus

### Create free pascal launcher

RUN echo "#!/bin/bash \nterminator -e fp" >> /usr/local/bin/startfp
RUN chmod +x /usr/local/bin/startfp

### Install visual studio code

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
RUN sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
RUN rm -f packages.microsoft.gpg
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y code

### Install sublime text

RUN wget -qO - http://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
RUN apt-get install -y apt-transport-https
RUN echo "deb http://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
RUN apt-get update
RUN apt-get install -y sublime-text

### Install git

RUN apt-get install -y git gitk

### Remove firefox

RUN rm /usr/bin/firefox

### Install Terminator

RUN apt-get install -y terminator

### Remove junk folders

RUN rm -rf /headless/install

### Update wallpaper

#COPY a2lab.jpg /headless/.config/a2lab.jpg
#RUN sed -i 's/bg_sakuli.png/a2lab.jpg/g' /headless/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

# Add desktop entries for each application

RUN rm /headless/Desktop/*
RUN cp /usr/share/applications/lazarus* /headless/Desktop
RUN cp /usr/share/applications/subl* /headless/Desktop
RUN cp /usr/share/applications/eclipse* /headless/Desktop
RUN cp /usr/share/applications/code.desktop /headless/Desktop
RUN cp /usr/share/applications/codeblocks* /headless/Desktop
RUN cp /usr/share/applications/monodevelop* /headless/Desktop
RUN cp /usr/share/applications/terminator* /headless/Desktop
RUN echo "[Desktop Entry]\nName=Free Pascal\nExec=startfp\nType=Application" >> /headless/Desktop/FreePascal.desktop
RUN echo "[Desktop Entry]\nName=Netbeans\nExec=/opt/netbeans/bin/netbeans\nIcon=/opt/netbeans/nb/netbeans.png\nType=Application" >> /headless/Desktop/Netbeans.desktop

RUN chown -R student:student /headless/Desktop/*
RUN chmod +x /headless/Desktop/*

### Enable encryption

#RUN cat /dockerstartup/vnc_startup.sh | grep " \$VNC_RESOLUTION &>"
#RUN sed -i 's/VNC_RESOLUTION \&/VNC_RESOLUTION -SecurityTypes=VncAuth \&/g' /dockerstartup/vnc_startup.sh
#RUN cat /dockerstartup/vnc_startup.sh
