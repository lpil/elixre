module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Input.View
import Results.View


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


subscriptions : Model -> Sub a
subscriptions model =
    Sub.none


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view model =
    div []
        [ Input.View.root
        , Results.View.root
        ]
