-- DEPENDENCIES --
-- xmonad git
-- xorg-server xorg-apps xorg-xinit xorg-xmessage
-- libx11 libxft libxinerama libxrandr libxss
-- pkgconf (xmonad dependencies)
--
-- polybar
--
-- xbacklight (brightness, optional)
-- flameshot (screenshots, optional)
-- volumeicon (audio keys, optional)
-- kitty (Terminal; can be changed below)

import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops

import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers
import qualified XMonad.Util.Hacks as Hacks

import Graphics.X11.ExtraTypes.XF86

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders

main :: IO ()
main = xmonad
     $ ewmhFullscreen
     $ ewmh
     $ withEasySB (statusBarProp "polybar main -r" (pure def)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask = modmask

	, layoutHook = myLayouts
	, manageHook = myManageHook
    , logHook = myLogHook
    , startupHook = myStartupHook

	, terminal = "kitty"

    , normalBorderColor = "#121212"
    , focusedBorderColor = "#AFAFAF"
	} `additionalKeys`
        [ ((modmask, xK_f), spawn "firefox")

        -- Brightness Keys
        , ((0, xF86XK_MonBrightnessDown), spawn "if [[ \"$(xbacklight -get)\" -le 10 ]]; then xbacklight -set 10; else xbacklight -dec 10; fi")
        , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 10")

        -- Screenshot (Mod+s)
        --, ((modmask, xK_s), spawn "scrot -s -f -p -F $HOME/Screenshots/$(date +%y-%m-%d-%H-%M-%S-%N)")
        , ((modmask, xK_s), spawn "flameshot gui")

        -- Lock (Mod+Shift+L)
        , ((modmask .|. shiftMask, xK_l), spawn "systemctl suspend")

        -- dmenu
        , ((modmask, xK_p), spawn "dmenu_run -fn 'JetBrainsMono NFM' -b")
        ]
    where
      modmask = mod4Mask

myStartupHook = do
    --spawnOnce "nm-applet"
    spawnOnce "volumeicon"
    --spawnOnce "xscreensaver -no-splash"

myLayouts = smartBorders tiled ||| Mirror tiled ||| noBorders Full
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1   -- Number of master windows
    ratio = 1/2   -- Size of master window (screen ratio)
    delta = 3/100 -- increments for resizing

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog            --> doFloat
    ]

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
  where fadeAmount = 0.8
