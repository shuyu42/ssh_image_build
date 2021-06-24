# To run the sample/test
1. Clone this repo, or just download `test_ssh.sh` and `Dockerfile` into a new local directory
2. Run `sh ./test_ssh.sh`
3. Expect to see "PASSED: SSH is setup correctly" printed

# Requirements
## at image build
1. Install SSH
2. Config SSHD server to the password-less
3. Config SSH client to avoid any prompt
4. Define `CMD` to start SSHD listening listening at port specified in a ENV_VAR (in the example, the env var is `$SSH_PORT`)

## at job submission
- For Customer BYO image, customer must provide AML which `ENV_VAR` should be used to specify the port
- For curated environment, both EMS and Runtime must hardcode the same `ENV_VAR` consistently
    > Having this implicit contract between EMS and Runtime is quite bad.<br>
    > The other option is to remove step #4 from image build requirements, and let Runtime handle SSHD start inside user container.
