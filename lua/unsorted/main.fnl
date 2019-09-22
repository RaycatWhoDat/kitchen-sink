;; -*- compile-command: "fennel --compile main.fnl > main.lua && love ." -*-
;; Untitled Game

(local (lg lk le la lt)
       (values
        love.graphics
        love.keyboard
        love.event
        love.audio
        love.timer))

(local view (require :fennelview))
(local lume (require :lume))
(local flux (require :flux))
;; (local tick (require "tick"))

(local player { :x 32 :y 32 :radius 0 :health 1 :speed 100 })
(local ring { :radius 500 :opacity 1 })

(local scene-key-map { })
(local movement-key-map { :a [:x -1] :d [:x 1] :w [:y -1] :s [:y 1] })

(local gamestate { :status :STARTING :status-hooks [] :timers [] :load [] :update [] :draw [] :keypressed [] })
(local gong (la.newSource "bowl.wav" :static))

(fn register-callback [callback-type callback]
    (if callback-type
        (let [number-of-callbacks
              (# (. gamestate callback-type))
              message
              (..
               "Added callback #"
                (+ number-of-callbacks 1)
                " to '"
                callback-type
                "'.")]
          ;; (print message)
          (table.insert (. gamestate callback-type) callback))
        (callback))
    (# (. gamestate callback-type)))

(fn unregister-callback [callback-type index]
    (if index
        (table.remove (. gamestate callback-type) index)
        (table.remove (. gamestate callback-type))))

(fn run-callbacks [list-of-callbacks ...]
    (each [key callback (pairs list-of-callbacks)]
          (when (= (type callback) :function)
            (callback (unpack [...])))))

(fn set-gamestate-status [state]
    (set gamestate.status state)
    (run-callbacks gamestate.status-hooks))

(fn quit-game [] (set-gamestate-status :STOPPING))

(fn move-player [axis direction dt]
    ;; (when (= axis "x")
    ;;   (set new-value (lume.clamp 0 player.width)))
    ;; (when (= axis "y")
    ;;   (set new-value (lume.clamp 0 player.height)))
    (let [[width height] [(lg.getDimensions)]]
      (var new-value (+ (. player axis) (/ (* direction (* player.speed player.health)) 60)))
      (when (not (= gamestate.status :COMPLETE)) (tset player axis new-value))
      (when (or (< (+ player.x player.radius) 0)
                (< (+ player.y player.radius) 0)
                (> (- player.x player.radius) width)
                (> (- player.y player.radius) height))
        (set-gamestate-status :COMPLETE)))

    (set player.health
         (lume.clamp
          (- 1 (/ (- (lume.distance player.x player.y ring.x ring.y) ring.radius) (* ring.radius 1.15)))
          0 1))

    (when (and (<= player.health 0.2) (not (= gamestate.status :COMPLETE)))
      (: (flux.to ring 1 { :radius (* ring.radius 1.5) :opacity (- ring.opacity 0.2) }) :ease :cubicout)
      (: (flux.to player 0.5 { :x ring.x :y ring.y :health 1 :radius (* player.radius 0.9) :speed (* player.speed 1.1) }) :ease :cubicout)))

(fn player.draw []
    (lg.setColor 0.1 0.1 0.1 player.health)
    (lg.circle :fill player.x player.y player.radius)
    ;; (lg.setColor 0.1 0.1 0.1 0.5)
    ;; (lg.circle :line player.x player.y player.radius)
    (lg.setColor 0 0 0))

(fn ring.draw []
    (lg.setColor 0 0 0 ring.opacity)
    (lg.circle :line ring.x ring.y ring.radius)
    (lg.setColor 0 0 0))

(fn scene-update [dt]
    (flux.update dt)
    (each [key action (pairs (lume.extend scene-key-map movement-key-map))]
          (table.insert action dt)
          (when (and (lk.isDown key) (> ring.radius player.radius))
            (if (= (type action) :function)
                (action)
                (move-player (unpack action))))))

(fn scene-draw []
    (lg.setBackgroundColor 1 1 1)
    (ring.draw)
    (player.draw))

(fn scene-keypressed [key]
    (when (= key :c) (set-gamestate-status :COMPLETE)))

(local main-scene { :update scene-update :draw scene-draw :keypressed scene-keypressed })

(local global-key-map { })
;; ===============

(fn love.keypressed [key]
    (when (= key :p)
        (if (= gamestate.status :RUNNING)
            (set-gamestate-status :PAUSED)
            (set-gamestate-status :RUNNING)))
    (when (= key :q) (quit-game))
    (run-callbacks gamestate.keypressed key))

(fn love.load [] 
    (register-callback
     :load
     (fn first-load []
         (register-callback
          :status-hooks
          (fn game-started []
              (when (= gamestate.status :STARTED)
                (set-gamestate-status :RUNNING)
                (: (flux.to player 1 { :radius 28 })
                   :after
                   ring 1 { :radius (* 32 1.15) }))))

         (register-callback
          :status-hooks
          (fn game-stopping []
              (when (= gamestate.status :STOPPING)
                (set-gamestate-status :STOPPED))))

         (register-callback
          :status-hooks
          (fn game-stopped []
              (when (= gamestate.status :STOPPED)
                (le.quit))))

         (register-callback
          :status-hooks
          (fn game-complete []
              (when (= gamestate.status :COMPLETE)
                (la.play gong)
                (flux.to ring 2 { :opacity 0 }))))
              
         (register-callback
          :update
          (fn key-handler []
              (each [key callback (pairs global-key-map)]
                    (when (and (lk.isDown key)
                               (= (type callback) :function))
                      (callback)))))

         (register-callback
          :update
          (fn upon-completion [dt]
              (when (and (= gamestate.status :COMPLETE) (: gong :isPlaying))
                (: gong :setVolume (- (: gong :getVolume) (/ dt 4)))
                (when (<= (: gong :getVolume) 0.01)
                  (: gong :stop)
                  (quit-game)))))

         ;; (register-callback
         ;;  :draw
         ;;  (fn debug-handler []
         ;;      (lg.print (: gong :getVolume) 8 465)
         ;;      (lg.print gamestate.status 8 480)))

         (let [[width height] [(lg.getDimensions)]]
           (set ring.x (math.floor (/ width 2)))
           (set ring.y (math.floor (/ height 2)))
           (set player.x ring.x)
           (set player.y ring.y))

         (register-callback :update main-scene.update)
         (register-callback :draw main-scene.draw)
         (register-callback :keypressed main-scene.keypressed)
         
         (set-gamestate-status :STARTED)))
    
    (run-callbacks gamestate.load))

(fn love.update [dt]
    (when (not (= gamestate.status :PAUSED))
      (run-callbacks gamestate.update dt)))

(fn love.draw [] (run-callbacks gamestate.draw))



