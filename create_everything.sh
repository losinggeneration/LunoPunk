#!/bin/sh
cat > LunoPunk/everything.moon <<EOL
-- Auto-generated with $0 on $(command date +"%F %T")

export ^

-- We tell Moonscript to export classes globally. Thus, we prevent collisions
-- based on namespace since we don't know what is going to be used.
--
-- This provides two options for getting the class, calling require again and
-- assigning it to a local variable. Alternatively, the namespaced version can
-- be used.

$(find LunoPunk -type d | sed "s,/,.,g" | awk '{print $1" = {}"}' | sort)

-- Now load each file to the correctly namespaced table
$(find LunoPunk -iname "*.moon" | sed -e "s,/,.,g" -e "s/\.moon$//" | awk '{ print $1" = require \""$1"\""}' | grep -v "everything" | sort)
EOL
