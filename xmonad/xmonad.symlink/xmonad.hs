import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.Spacing
import XMonad.Hooks.FadeInactive
import XMonad.Layout.NoBorders
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = noBorders $
                       avoidStruts $
                       smartSpacing 4 $
                       Tall 1 (3/100) (1/2)
                       ||| Full
        , logHook = do fadeInactiveLogHook 0.9
                       dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((mod4Mask .|. shiftMask, xK_t), sendMessage ToggleStruts)
        , ((mod4Mask .|. shiftMask, xK_o), spawn "amixer -D pulse sset Master 5%+")
        , ((mod4Mask .|. shiftMask, xK_p), spawn "amixer -D pulse sset Master 5%-")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
