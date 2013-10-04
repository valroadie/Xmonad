import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Actions.SpawnOn
 
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]
 
main = do
    xmproc <- spawnPipe "/usr/bin/xmobar ~/xmobarrc" -- this is where you place your xmobarrc exec
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#FFFF00" "" . shorten 50 -- this controls the color of xmobar
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "")
        , ((0, xK_Print), spawn "")
        , ((mod4Mask, xK_i), spawn "iceweasel") -- obligatory note about replacing these with the keys and apps you want to run
        , ((mod4Mask .|. shiftMask, xK_Return), spawn "terminator")
        , ((mod4Mask, xK_e), spawn "evolution")
        , ((mod4Mask, xK_x), spawn "xchat")
        , ((mod4Mask, xK_c), kill)
        , ((mod4Mask, xK_g), spawn "geany")
        , ((mod4Mask, xK_v), spawn "vlc")
        , ((mod4Mask, xK_0), spawn "scrot")
        , ((mod4Mask, xK_f), spawn "thunar")
        ]
