-- Adapted from https://github.com/tfcace/tkmp/blob/main/rex/tkmp.lua
-- Copyright (c) 2026 Assaf Schwartz
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local M = {}
local terminal = "com.superlogical.terminal"
local used_count

local function unescape_url(path)
  return (path:gsub("%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end))
end

local function cwd_of(block)
  local process = rex.block.call(terminal, "process", { block_id = block })
  if process then
    local foreground = process.foreground or process.child or {}
    if foreground.cwd then
      return foreground.cwd
    end
    if process.child and process.child.cwd then
      return process.child.cwd
    end
  end
  local reported = rex.block.call(terminal, "pwd", { block_id = block })
  if reported and reported.pwd then
    return unescape_url((reported.pwd:gsub("^file://[^/]*", "")))
  end
end

local function resolve(raw, cwd)
  local path = raw
  if path:match("^file://") then
    path = unescape_url((path:gsub("^file://[^/]*", "")))
  end
  if path:sub(1, 2) == "~/" then
    path = os.getenv("HOME") .. path:sub(2)
  elseif path:sub(1, 1) ~= "/" then
    if not cwd then
      return nil
    end
    path = cwd .. "/" .. path:gsub("^%./", "")
  end
  local file = io.open(path, "r")
  if file then
    file:close()
    return path
  end
end

local function is_markdown(path)
  local lower = path:lower()
  return lower:match("%.md$") or lower:match("%.markdown$")
end

local function clean(word)
  return (word:gsub("[%.,:;]+$", ""):gsub(":%d+:%d+$", ""):gsub(":%d+$", ""))
end

local function canon(path)
  for _, dir in ipairs({ "tmp", "var", "etc" }) do
    if path:sub(1, #dir + 10) == "/private/" .. dir .. "/" then
      return path:sub(9)
    end
  end
  return path
end

-- Prefer a freshly copied match, then the path nearest the terminal cursor.
function M.find(text, cursor_row, cwd, links, copied)
  copied = copied and canon(copied)
  local newest_link
  for i = #links, 1, -1 do
    if is_markdown(links[i]) then
      local path = resolve(links[i], cwd)
      if path then
        if canon(path) == copied then
          return path
        end
        newest_link = newest_link or path
      end
    end
  end
  local lines = {}
  for line in (text .. "\n"):gmatch("(.-)\n") do
    lines[#lines + 1] = line
  end
  local best, best_score
  for i = math.max(1, #lines - 2000), #lines do
    for word in lines[i]:gmatch("[%w%._%-%+~/:@%%]+") do
      local candidate = clean(word)
      if is_markdown(candidate) then
        local path = resolve(candidate, cwd)
        if path then
          if canon(path) == copied then
            return path
          end
          local distance = cursor_row - i
          local score = distance >= 0 and distance or -distance * 3
          if not best_score or score <= best_score then
            best, best_score = path, score
          end
        end
      end
    end
  end
  return best or newest_link
end

local pasteboard_script = [[
ObjC.import("AppKit");
var p = $.NSPasteboard.generalPasteboard;
var s = p.stringForType($.NSPasteboardTypeString);
p.changeCount + "\n" + (s.isNil() ? "" : s.js)
]]

local function copied_path(cwd)
  local ok, result = pcall(
    rex.exec,
    { "/usr/bin/osascript", "-l", "JavaScript", "-e", pasteboard_script },
    { timeout = 2 }
  )
  if not ok or not result or not result.ok then
    return nil
  end
  local count, text = result.stdout:match("^(%d+)\n(.-)%s*$")
  if not count or count == used_count then
    return nil
  end
  text = text:match("^%s*(.-)$")
  if text == "" or text:find("\n") or #text > 4096 then
    return nil
  end
  text = clean(text)
  if is_markdown(text) then
    return resolve(text, cwd), count
  end
end

function M.open(ctx)
  local block = ctx.block_id
  if not block then
    return nil, "no terminal is focused"
  end
  local text, err = rex.block.call(terminal, "format", { block_id = block, format = "text" })
  if not text then
    return nil, err
  end
  local vt = rex.block.call(terminal, "format", {
    block_id = block,
    format = "vt",
    extra_cursor = true,
    extra_hyperlink = true,
  })
  local content = (vt and vt.content) or ""
  local links = {}
  for url in content:gmatch("\27%]8;[^;]*;([^\27\7]+)") do
    links[#links + 1] = url
  end
  local size = rex.block.call(terminal, "size", { block_id = block }) or {}
  local row = tonumber(content:match(".*\27%[(%d+);%d+H")) or (size.rows or 0)
  local total = select(2, (vt and content or text.content):gsub("\n", "")) + 1
  local cursor_row = total - (size.rows or 0) + row
  local cwd = cwd_of(block)
  local copied, count = copied_path(cwd)
  local path = M.find(text.content, cursor_row, cwd, links, copied)
  if not path then
    return nil, "no Markdown file found in the terminal output"
  end
  if copied and canon(path) == canon(copied) then
    used_count = count
  end

  local result, open_err = rex.exec({ "/opt/homebrew/bin/md-viewer", "open", path }, {
    env = { REX_BLOCK = block, REX_SESSION = ctx.session_id },
    timeout = 10,
  })
  if not result then
    return nil, open_err
  end
  if not result.ok then
    return nil, result.stderr ~= "" and result.stderr or "md-viewer could not open the file"
  end
  return { path = path }
end

rex.action({
  name = "md_viewer_nearest",
  title = "Preview nearest Markdown file",
  description = "Open the copied Markdown path or the file nearest the terminal cursor in md-viewer",
  run = function(ctx)
    local result, err = M.open(ctx)
    if not result then
      error(err)
    end
    return result
  end,
})

return M
