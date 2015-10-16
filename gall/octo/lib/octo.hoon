::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                                            ::
::  The lib/ directory is meant for library cores. Libraries in lib/ can be   ::
::  loaded with /+, a %ford rune.                                             ::
::                                                                            ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                      ::  ::
::::  /hoon/octo/lib                                    ::::::  dependencies
  ::                                                    ::  ::
/?    310                                               ::  arvo version
/-    octo                                              ::  structures
::                                                      ::  ::
::::                                                    ::::::  semantics
  !:                                                    ::  ::
[. ^octo]
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::                                                                            ::
::  Below is the library core. The top-level core only has three arms, and    ::
::  the first, ++icon, is a simple utility function from true/false to X/O.   ::
::                                                                            ::
::  ++bo contains gates that operate with a board in their context, and ++go  ::
::  contains gates that operate with a game state update (paired with the     ::
::  source ship) in their context. These contexts are passed in the sample to ::
::  the ++bo and ++go cores themselves, in a standard Hoon idiom that is      ::
::  somewhat similar to the OOP concept of methods. For example, ++bit would  ::
::  be used like this:                                                        ::
::                                                                            ::
::  (~(bit bo board-here) location-here)                                      ::
::                                                                            ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
|%                                                      ::
++  icon   |=(? ?:(+< 'X' 'O'))                         ::  display at
++  bo                                                  ::  per board
  |_  bud=board                                         ::
  ++  bit  |=(@ =(1 (cut 0 [+< 1] bud)))                ::  moved at address
  ++  get  |=(point (bit (off +<)))                     ::  get point
  ++  jon  a/(turn (gulf 0 8) |=(@ b/(bit +<)))         ::  to json
  ++  off  |=(point (add x (mul 3 y)))                  ::  bitfield address
  ++  set  |=(point (con bud (bex (off +<))))           ::  set point
  ++  win  %-  lien  :_  |=(a=@ =(a (dis a bud)))       ::  test for win
           (rip 4 0wl04h0.4A0Aw.4A00s.0e070)            ::  with bitmasks
  --                                                    ::
++  go                                                  ::  play from
  |_  [src=ship game]                                   ::
  ++  at  |_  point                                     ::  per point
          ++  g  `game`+>+<+                            ::  game
          ++  k  &(!|(x o) ept)                         ::  legal move
          ++  m  ?.(k [| g] [& g:t:?:(who y p)])        ::  move
          ++  o  (~(get bo boo) +<)                     ::  old at o
          ++  p  .(boo (~(set bo boo) +<), q.sag `src)  ::  play at o
          ++  t  .(who !who)                            ::  take turn
          ++  v  ?:(x (icon &) ?:(o (icon |) '.'))      ::  view
          ++  x  (~(get bo box) +<)                     ::  old at x
          ++  y  .(box (~(set bo box) +<), p.sag `src)  ::  play at x
          --                                            ::
  ++  ept  =+(own |(&(=(~ -) !=(oth `src)) =(`src -)))  ::  we can play
  ++  hey  |=(? +>+<+(aud ((stat ship) +< src aud)))    ::  enter/leave
  ++  muy  |=  (list ship)  ?~  +<  +>+<+               ::  many in audience
           $(+< t.+<, aud ((stat ship) & i.+< aud))     ::
  ++  nam  =+  ?:  =(p.sag `src)  ['=' (icon &) ~]      ::  print name
               ?:  =(q.sag `src)  ['=' (icon |) ~]      ::
           ""  (welp (scow %p src) `tape`-)             ::
  ++  new  +<+(boo 0, box 0, who &, sag [~ ~])          ::  reset game
  ++  oth  own(who !who)                                ::  who owns other turn
  ++  own  ?:(who p.sag q.sag)                          ::  who owns this turn
  ++  res  ?.  |(~(win bo box) ~(win bo boo))           ::  possible result
           ?:  =(511 (con boo box))                     ::
           `"tie :-("  ~  `"{<nam>} wins"               ::
  ++  row  |=  y=@  :-  (add y '1')  %-  zing           ::  print row
           (turn (gulf 0 2) |=(@ ~[' ' ~(v at y +<)]))  ::
  ++  str  =+  [own ~[(icon who)]]  ^-  tape            ::  print player
            ?~(-< -> (scow %p u.-<))                    ::
  ++  tab  ~["+ 1 2 3" (row 0) (row 1) (row 2)]         ::  print table
  ++  vew  =-  ?:  =(~ -)  ~  :(weld "[" - "]")         ::  print watchers
           =+  dow=(~(tap by aud))  |-  ^-  tape        ::
           ?~  dow  ~  =+  mor=$(dow t.dow)             ::
           :(weld nam(src p.i.dow) ?~(mor "" ", ") mor) ::
  ++  voy   =+  ~[(icon who)]  %+  weld  vew            ::  print prompt
            ?.(ept " ({-}'s turn) " ": {-} (row/col): ")::
  --
--
