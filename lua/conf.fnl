;; -*- compile-command: "fennel --compile conf.fnl > conf.lua" -*-

(fn love.conf [t]
    (doto t.window
          (tset "borderless" true)
          (tset "title" "July 13th, 2018")
          (tset "width" 500)
          (tset "height" 500))) 
