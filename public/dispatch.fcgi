
#!/bin/bash
unset GEM_HOME
unset GEM_PATH
export HOME='/home/holachef'
export GEM_HOME='/home/holachef/.gems'
export GEM_PATH='/home/holachef/.gems'
export PATH=/home/holachef/ruby/bin:"$PATH"
err_log_file="/home/holachef/qa.holachef.com/shared/log/dispatch_error.log"
exec /home/holachef/ruby/bin/ruby "/home/holachef/qa.holachef.com/current/holachef_dispatch.rb" "$@" 2>>"${err_log_file}"
