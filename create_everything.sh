#!/bin/sh
echo "-- Auto-generated with $0 on $(command date +"%F %T")" > LovePunk/everything.moon
echo >> LovePunk/everything.moon
cat >> LovePunk/everything.moon <<EOL
export ^

-- We tell Moonscript to export classes globally. Thus, we prevent collisions
-- based on namespace since we don't know what is going to be used.
--
-- This provides two options for getting the class, calling require again and
-- assigning it to a local variable. Alternatively, the namespaced version can
-- be used.
EOL
find LovePunk -type d | sed "s,/,.,g" | awk '{print $1" = {}"}' >> LovePunk/everything.moon
echo >> LovePunk/everything.moon
echo "-- Now load each file to the correctly namespaced table" >> LovePunk/everything.moon
find LovePunk -iname "*.moon" | sed -e "s,/,.,g" -e "s/\.moon$//" | awk '{ print $1" = require \""$1"\""}' | grep -v "everything" | sort >> LovePunk/everything.moon
