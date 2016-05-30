FROM centos:7

RUN echo "--- Get updated" \
 && yum update -y \
 && echo "--- Get epel for supervisor" \
 && yum install -y epel-release \
 && echo "--- Install supervisor" \
 && yum install -y supervisor wget \
 && echo "--- Install dev/setup tools" \
 && yum install -y python-pip gcc make gcc-c++ glibc-static git \
 && echo "--- Add pygment for code highlights and dumb-init for service running" \
 && pip install pygments dumb-init \
 && echo "--- Install hugo" \
 && wget https://github.com/spf13/hugo/releases/download/v0.15/hugo_0.15_linux_amd64.tar.gz \
 && tar xvf hugo_0.15_linux_amd64.tar.gz \
 && mv hugo_0.15_linux_amd64/hugo_0.15_linux_amd64 /usr/bin/hugo \
 && rm -rf hugo_0.15_linux_amd64.tar.gz hugo_0.15_linux_amd64 \
 && echo "--- Install cloud9 ide" \
 && git clone --depth=1 https://github.com/c9/core.git /cloud9 \
 && /cloud9/scripts/install-sdk.sh \
 && echo "--- Clean up, isle 9!" \
 && yum -y history undo last \
 && yum clean all

ADD container-files/ /

CMD [ "dumb-init", "/start.sh" ]
