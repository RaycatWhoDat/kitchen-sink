;; -*- mode: Fennel; compile-command: "fennel --compile fennel-testing.fnl > main.lua; ./love.app/Contents/MacOS/love ." -*-

;; Testing Fennel. It's kinda nice.

(let [lg love.graphics
         lk love.keyboard
         le love.event
         message {:x 25 :y 25 :text "This is the message." :speed 50}
         player {:x 25 :y 25 :w 50 :h 50 :speed 50 :color {255, 0, 0}}]

  (set love.load
       (fn load []
           (print (toString player.color))))

  (set love.keypressed
       (fn keypressed [key]
           (when (= "escape" key)
             (le.quit))
           (when (= "space" key)
             (set message.speed (* -1 message.speed)))))
  
  (set love.update
       (fn update [dt]
           (set message.y (+ message.y (* message.speed dt)))))
  
  (set love.draw
       (fn draw []
           (lg.setColor (unpack player.color) 100)
           (lg.rectangle "fill" player.x player.y player.w player.h)
           (lg.setColor (unpack player.color) 255)
           (lg.rectangle "line" player.x player.y player.w player.h))))
