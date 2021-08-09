FROM viennaglobal.azurecr.io/azureml/azureml_7e757fabd344a3c37f23817d7bcb7998

# 1. Config SSHD server to be password-less
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh/
RUN mkdir -p /var/run/sshd
RUN cat /dev/zero | ssh-keygen -q -N ""
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# 2. Config SSH client to avoid any prompt
RUN touch /root/.ssh/config
RUN chmod 600 /root/.ssh/config
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config
RUN echo "UserKnownHostsFile /dev/null" >> /root/.ssh/config
# fail ssh if password is needed
RUN echo "PasswordAuthentication no" >> /root/.ssh/config

# 3.
ENV OMPI_ALLOW_RUN_AS_ROOT=1

# https://www.open-mpi.org/faq/?category=rsh
# The plm_rsh_agent MCA parameter accepts a colon-delimited list of programs to search for in your path to use as the remote startup agent. The default value is ssh : rsh, meaning that it will look for ssh first, and if it doesn't find it, use rsh. You can change the value of this parameter as relevant to your environment, such as simply changing it to rsh or rsh : ssh if you have a mixture. The deprecated forms pls_rsh_agent and orte_rsh_agent will also work.

# Define `CMD` to start SSHD listening listening at port specified in a env var
ENTRYPOINT [ "sh", "-c", "if [ -z ${SSH_PORT} ] ; then echo '${SSH_PORT} not defined' && sleep infinity ; else /usr/sbin/sshd -Dp ${SSH_PORT} ; fi" ]
