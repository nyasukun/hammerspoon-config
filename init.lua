-- 共通修飾キー
local hyper      = {"ctrl", "alt"}
local hyperShift = {"ctrl", "alt", "shift"}

-- toggle show/hide
function toggleApp(appName, appLocation)
  return function()
    local app = hs.application.get(appName)
    if app == nil then
      hs.application.launchOrFocus(appLocation)
    elseif app:isFrontmost() then
      app:hide()
    else
      hs.application.launchOrFocus(appLocation)
      app = hs.application.get(appName)
      if app then
        local win = app:focusedWindow()
        if win then
          win:focus()
        end
      end
    end
  end
end

--------------------------------------------------
-- アプリ起動用ホットキー
--------------------------------------------------

-- OneNote
hs.hotkey.bind(hyper, "n",
  toggleApp("OneNote", "/Applications/Microsoft OneNote.app"))

-- Warp
hs.hotkey.bind(hyper, "j",
  toggleApp("Warp", "/Applications/Warp.app"))

-- Antigravity (VS Code の代わり)
hs.hotkey.bind(hyper, "k",
  toggleApp("Antigravity", "/Applications/Antigravity.app"))

-- Miro
hs.hotkey.bind(hyper, "m",
  toggleApp("Miro", "/Applications/Miro.app"))

-- Webex
hs.hotkey.bind(hyper, "w",
  toggleApp("Webex", "/Applications/Webex.app"))

--------------------------------------------------
-- アクティブウィンドウを隣のディスプレイへ
--------------------------------------------------

function moveWindowToEast()
  return function()
    local displays = hs.screen.allScreens()
    local win = hs.window.focusedWindow()
    if not win then return end
    local nextDisplay = win:screen():toEast()
    if nextDisplay == nil then
      win:moveToScreen(displays[1], false, true)
    else
      win:moveToScreen(nextDisplay, false, true)
    end
  end
end

function moveWindowToWest()
  return function()
    local displays = hs.screen.allScreens()
    local win = hs.window.focusedWindow()
    if not win then return end
    local nextDisplay = win:screen():toWest()
    if nextDisplay == nil then
      win:moveToScreen(displays[#displays], false, true)
    else
      win:moveToScreen(nextDisplay, false, true)
    end
  end
end

hs.hotkey.bind(hyperShift, "right", moveWindowToEast())
hs.hotkey.bind(hyperShift, "left",  moveWindowToWest())

--------------------------------------------------
-- Magnet 風ウィンドウ整列
--------------------------------------------------

-- 左半分
hs.hotkey.bind(hyper, "left", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local screen = win:screen()
  local max = screen:frame()
  local f = win:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)

-- 右半分
hs.hotkey.bind(hyper, "right", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local screen = win:screen()
  local max = screen:frame()
  local f = win:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f, 0)
end)

-- 最大化
hs.hotkey.bind(hyper, "up", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local screen = win:screen()
  local max = screen:frame()
  local f = win:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f, 0)
end)

-- 画面中央
hs.hotkey.bind(hyper, "down", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local screen = win:screen()
  win:centerOnScreen(screen, true, 0)
end)
