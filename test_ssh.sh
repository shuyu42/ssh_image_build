docker build -t ssh_img .
docker rm --force ssh_test

# Allow caller (runtime) to pick which port to use when starting the container
export SSH_PORT=54321
docker run -d --net=host -e SSH_PORT --name ssh_test ssh_img

# Try ssh to container from the container. It will only work if SSHD/SSH is configured correctly
docker exec ssh_test ssh -p $SSH_PORT localhost "mkdir -p /tmp/ssh; touch /tmp/ssh/test; echo succeeded >> /tmp/ssh/test"

# Test if the ssh invocation above works
docker exec ssh_test cat /tmp/ssh/test

if [ $? -ne 0 ]
then
    echo "*** FAILED: There is issue with SSH setup ***"
else
    echo "*** PASSED: SSH is setup correctly ***" # <---- expected to see this
fi
