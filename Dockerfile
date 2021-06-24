FROM ubuntu:18.04

# 1. Install SSH
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openssh-server && \
    apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 2. Config SSHD server to be password-less
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh/
RUN mkdir -p /var/run/sshd
RUN cat /dev/zero | ssh-keygen -q -N ""
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# 3. Config SSH client to avoid any prompt
RUN touch /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config
RUN echo "UserKnownHostsFile /dev/null" >> /root/.ssh/config
# fail ssh if password is needed
RUN echo "PasswordAuthentication no" >> /root/.ssh/config

# 4. Define `CMD` to start SSHD listening listening at port specified in a env var
ENTRYPOINT [ "sh", "-c", "/usr/sbin/sshd -Dp ${SSH_PORT}" ]
