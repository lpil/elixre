module Main exposing (..)

import Html
import Types exposing (..)
import State
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
