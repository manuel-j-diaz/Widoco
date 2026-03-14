#!/bin/sh
# Fix volume permissions (may be root-owned from another container), then drop to widoco user
chown -R widoco:widoco /output
exec gosu widoco java -Dlog4j2.StatusLogger.level=OFF ${JAVA_OPTS} -jar widoco.jar "$@"
