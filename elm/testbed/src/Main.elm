module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

main =
    Browser.sandbox { init = 0
                    , update = update
                    , view = view
                    }

type Event = Increment | Decrement
    
update event model =
    case event of
        Increment ->
            model + 1
                
        Decrement ->
            model - 1

buttonStyle =
    [ style "width" "200px"
    , style "height" "32px"
    , style "display" "inline-block"
    , style "padding" "0 10px"
    ]

newButtonStyle =
    [ style "width" "200px"
    , style "height" "32px"
    , style "display" "inline-block"
    , style "padding" "0 10px"
    ]
                
html component styles otherAttributes content =
    component (styles ++ otherAttributes) content
        
view model =
    div [] [ html button buttonStyle [ onClick Decrement ] [ text "-" ]
           , div [] [ text (String.fromInt model) ]
           , html button buttonStyle [ onClick Increment ] [ text "-" ]
           ]
