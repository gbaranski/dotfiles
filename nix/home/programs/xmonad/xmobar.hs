Config { 
   -- appearance
     font =         "xft:Bitstream Vera Sans Mono:size=9:bold:antialias=true"
   , bgColor =      "#282C34"
   , fgColor =      "#ABB2BF"
   , position =     Top
   , border =       BottomB
   , borderColor =  "#56B6C2"

   -- layout
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment
   , template = " %StdinReader%} {%battery% | %multicpu% | %multicoretemp% | %memory% | %date% "

   -- general behavior
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , persistent =       True    -- enable/disable hiding (True = disabled)

   -- plugins
   --   Numbers can be automatically colored according to their value. xmobar
   --   decides color based on a three-tier/two-cutoff system, controlled by
   --   command options:
   --     --Low sets the low cutoff
   --     --High sets the high cutoff
   --
   --     --low sets the color below --Low cutoff
   --     --normal sets the color between --Low and --High cutoffs
   --     --High sets the color above --High cutoff
   --
   --   The --template option controls how the plugin is displayed. Text
   --   color can be set by enclosing in <fc></fc> tags. For more details
   --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
   , commands = 

        [ 

        -- cpu activity monitor
        Run MultiCpu       [ "--template" , "CPU: <total>%"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "#98C379"
                             , "--normal"   , "#E5C07B"
                             , "--high"     , "#E06C75"
                             ] 10

        -- cpu core temperature monitor
        , Run MultiCoreTemp  [ "--template" , "Temp: <max>°C"
                             , "--Low"      , "50"        -- units: °C
                             , "--High"     , "80"        -- units: °C
                             , "--low"      , "#98C379"
                             , "--normal"   , "#E5C078"
                             , "--high"     , "#E06C75"
                             ] 50
                          
        -- memory usage monitor
        , Run Memory         [ "--template" ,"<used>MiB"
                             , "--Low"      , "4000"        -- units: MiB
                             , "--High"     , "8000"        -- units: MiB
                             , "--low"      , "#98C379"
                             , "--normal"   , "#E5C07B"
                             , "--high"     , "#E06C75"
                             ] 50

        -- battery monitor
        , Run Battery        [ "--template" , "BAT: <acstatus>"
                             , "--Low"      , "20"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "#E06C75"
                             , "--normal"   , "#E5C07B"
                             , "--high"     , "#98C379"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#C678DD>CHR <left>%</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#98C379>FULL</fc>"
                             ] 50

        -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "<fc=#ABB2BF>%a %F - %T</fc>" "date" 10
        
        -- Read from xmonad stdin
        , Run StdinReader

        ]
   }