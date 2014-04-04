#!/bin/sh
cat > LunoPunk/everything.moon <<EOL
-- Auto-generated with $0 on $(command date +"%F %T")

-- We tell Moonscript to export classes globally. Thus, we prevent collisions
-- based on namespace since we don't know what is going to be used.
--
-- This provides two options for getting the class, calling require again and
-- assigning it to a local variable. Alternatively, the namespaced version can
-- be used.

import mixin_table from require "moon"

$(find LunoPunk -type d | sed "s,/,.,g" | awk '{print $1" = {}"}' | sort)

-- Now load each file to the correctly namespaced table
$(find LunoPunk -iname "*.moon" | sed -e "s,/,.,g" -e "s/\.\(\w*\)\.moon$/ \1/" | awk '{ print "mixin_table "$1", if t = assert(require \""$1"."$2"\") then t if type(t) == \"table\" else {} else {}"}' | grep -v "everything" | sort)

{ :LunoPunk }
EOL
