
#!/bin/bash

sh 1-setup-minishift.sh
echo ">>>> 1 minishft console: http://`minishift ip`:8443 <<<<"
sh 2-login-minishift.sh
echo ">>>> 2 loged as: `oc whoami` <<<<"
sh 3-install-kether.sh
echo ">>>> 3.1 installing kether <<<<"
