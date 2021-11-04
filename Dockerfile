FROM tmcmm/netdebug:v1
CMD ["/bin/sh"]
LABEL tiagocorreia.netdebug.alpine.version=v2.0
RUN /bin/sh -c set -ex     \
    && echo "http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories     \
    && echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories     \
    && echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories     \
    && apk update     \
    && apk upgrade
RUN apk add netcat-openbsd \
    && apk add nmap \
    && apk add curl \
    && apk add iputils \
    && apk add tcpdump \
    && apk add vim \
    && apk add nginx \
    && apk add tshark \
    && apk add iftop \
    && apk add git \
    && apk add jq \
    && apk add openssh \
    && apk add bind-tools \
    && apk add tcptraceroute \
    && apk add bc \
    && apk add hping3 --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    && apk add bind-tools \
    && curl -L "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl # buildkit
ENV HOSTNAME=netdebug
#RUN /bin/sh -c set -x; cd "$(mktemp -d)" ;  OS="$(uname | tr '[:upper:]' '[:lower:]')" ;  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" ;  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.4.2/krew-darwin_arm64.tar.gz" ;  tar zxvf krew-darwin_arm64.tar.gz ;  KREW=./krew-"${OS}_${ARCH}" ;  "$KREW" install krew # buildkit
#RUN /bin/sh -c export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" # buildkit
RUN /bin/sh -c wget http://www.vdberg.org/~richard/tcpping ;    cp tcpping /usr/bin ;    chmod 755 tcpping # buildkit
RUN /bin/sh -c echo -e 'This netdebug container has these tools available: [netcat-openbsd, nmap, curl, iputils, tcpdump, nginx, openssh , hping3, kubectl, sniff, conntrack, tcping, dnsutils, jq]' # buildkit
ENV LIST='This netdebug container has these tools available: [netcat-openbsd, nmap, curl, iputils, tcpdump, nginx, openssh , hping3, kubectl, sniff, conntrack, tcping, dnsutils, jq]'
USER 1000:1000
WORKDIR /root
CMD ["/bin/sh"]
