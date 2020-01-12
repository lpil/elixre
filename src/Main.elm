module Main exposing (init, main, subscriptions)

import Html
import State
import Types exposing (..)
import View


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = View.root
        , subscriptions = subscriptions
        , update = State.update
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( State.init flags
    , Cmd.none
    )


subscriptions : Model -> Sub a
subscriptions model =
    Sub.none
