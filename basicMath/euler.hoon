=<  (sum 1.000)
|%
++  three 
  |=  a=@
  =|  b=@
  |-  ^-  @u
  ?:  (lth a b)
    0
  (add b $(b (add 3 b)))

++  five
  |=  a=@
  =|  b=@
  |-  ^-  @
  ?:  (lte a b)
    0
  ?:  =((mod b 3) 0)
    $(b (add b 5))
  (add b $(b (add b 5)))

++  sum
  |=  a=@u
  (add (five a) (three a))
--
