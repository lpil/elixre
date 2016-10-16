module Main exposing (..)

import Html.App as App
import Types exposing (..)
import State
import View


main : Program Flags
main =
    App.programWithFlags
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
