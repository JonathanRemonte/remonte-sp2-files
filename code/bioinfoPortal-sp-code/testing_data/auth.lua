-- browsing.lua
-- Simulate random page browsing with optional authentication

-- Define available endpoints
local paths = {
  "/",
  "/genview",
  "/synview",
  "/service",
  "/service/variant-calling",
  "/service",
  "/training",
  "/training/bbioinformatics-course",
  "/training/bdigital-phenotyping",
  "/account",
  "/mapman",
  "/genbrowse",
}

-- Add your session token (e.g., from a logged-in session cookie)
session_cookie = "SESS49960de5880e8c687434170f6476605b=5b8k-gdL9I8eM2dzt%2CJEmXIo3DRTNyHgyPdS3v7Jt84YjEW8"

-- Called once per thread
function init(args)
  counter = 1
end

-- Called for every HTTP request
function request()
  local path = paths[counter]
  counter = counter + 1
  if counter > #paths then
    counter = 1
  end

  return wrk.format("GET", path, {
    ["Cookie"] = session_cookie
  })
end