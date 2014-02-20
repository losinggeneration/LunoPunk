-- License (MIT)
--
-- Copyright (C) 2013 by Leaf Corcoran
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

log = (str="") ->
  io.stderr\write str .. "\n"

create_counter = ->
  setmetatable {}, __index: (name) =>
    with tbl = setmetatable {}, __index: => 0
      @[name] = tbl

position_to_lines = (file_content, positions) ->
  lines = {}
  current_pos = 0
  line_no = 1
  for char in file_content\gmatch "."
    if count = rawget positions, current_pos
      lines[line_no] = count

    if char == "\n"
      line_no += 1

    current_pos += 1

  lines

no_coverage = (line) ->
  nc = {
    "^(%s*)$",
    "^(%s*%-%-).*$",
    "[:=]?%s*[-=]>%s*$",
    "^%s*require",
    "^%s*export",
    "=?%s*class%s*",
    "^%s*else%s*$",
    "(%w+%s*=%s*)require%s*['\"(]",
  }

  for c in *nc
    return true if c

  false

file_coverage = (fname, positions) ->
  file = assert io.open fname
  content = file\read "*a"
  file\close!

--   return {name: fname, source: content .. "\n", coverage: position_to_lines(content, positions)}`
  lines = position_to_lines content, positions
  line_no = 1
  cov = {}
  for line in (content .. "\n")\gmatch "(.-)\n"
    cov[line_no] = lines[line_no] or (if no_coverage(line) then nil else 0)
    line_no += 1

  {name: fname, source: content .. "\n", coverage: cov}

format_file = (fname, positions) ->
  file = assert io.open fname
  content = file\read "*a"
  file\close!

  lines = position_to_lines content, positions
  log "------| @#{fname}"
  line_no = 1
  for line in (content .. "\n")\gmatch "(.-)\n"
    foramtted_no = "% 5d"\format(line_no)
    sym = lines[line_no] and "*" or " "
    log "#{sym}#{foramtted_no}| #{line}"
    line_no += 1

  log!

class CodeCoverage
  new: =>
    @reset!

  reset: =>
    @line_counts = create_counter!

  start: =>
    debug.sethook @\process_line, "l"

  stop: =>
    debug.sethook!

  print_results: =>
    @format_results!

  process_line: (_, line_no) =>
    debug_data = debug.getinfo 2, "S"
    source = debug_data.source
    @line_counts[source][line_no] += 1

  process_positions: =>
    line_table = require "moonscript.line_tables"
    @positions = create_counter!

    for file, lines in pairs @line_counts
      file_table = line_table[file]
      continue unless file_table

      for line, count in pairs lines
        position = file_table[line]
        continue unless position
        @positions[file][position] += count

  file_coverage: (fname) =>
    @process_positions!
    file_coverage fname, @positions[fname]

  format_file: (fname) =>
    @process_positions!
    format_file fname, @positions[fname]

  format_results: =>
    @process_positions!
    for file, ps in pairs @positions
      format_file file, ps

{ :CodeCoverage }
