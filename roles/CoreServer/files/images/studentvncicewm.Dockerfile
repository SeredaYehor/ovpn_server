FROM consol/ubuntu-icewm-vnc:latest

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

RUN echo "terminator -e fp" >> /usr/local/bin/startfp
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

### Remove unused launchers

RUN rm /headless/.icewm/menu
RUN rm /headless/.icewm/toolbar

# Add desktop entries for each application

RUN echo "prog Terminal /usr/share/pixmaps/terminator.png terminator" >> /headless/.icewm/menu
RUN echo "prog [C++]\ codeblocks /usr/share/codeblocks/icons/app_64.xpm /usr/bin/codeblocks" >> /headless/.icewm/menu
RUN echo "prog [C#]\ Monodevelop /usr/share/icons/hicolor/scalable/apps/monodevelop.svg /usr/bin/monodevelop" >> /headless/.icewm/menu
RUN echo "prog [Java]\ eclipse /usr/share/eclipse/plugins/org.eclipse.platform_3.8.1.dist/eclipse256.png /usr/bin/eclipse" >> /headless/.icewm/menu
#RUN echo "prog [Java]\ netbeans /opt/netbeans/nb/netbeans.png /usr/bin/netbeans" >> /headless/.icewm/menu
RUN echo "prog [Pascal]\ Lazarus /usr/lib/lazarus/1.6/images/icons/lazarus.ico lazarus-ide" >> /headless/.icewm/menu
RUN echo "prog [Pascal]\ FreePascal fp startfp" >> /headless/.icewm/menu
RUN echo "prog VisualStudio /usr/share/pixmaps/com.visualstudio.code.png code" >> /headless/.icewm/menu
RUN echo "prog SublimeText /opt/sublime_text/Icon/256x256/sublime-text.png subl" >> /headless/.icewm/menu
