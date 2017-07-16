yarn application -list 2>/dev/null | grep ^appli | awk '{print $1}' | xargs --no-run-if-empty yarn application -kill 2>/dev/null
