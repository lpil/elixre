module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Types exposing (..)
import Input.View
import Results.View
import Input.State


main : Program Flags
main =
    App.programWithFlags
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { inputModel = Input.State.init flags.regexEndpoint }
    , Cmd.none
    )


subscriptions : Model -> Sub a
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ App.map InputMsg (Input.View.root model.inputModel)
        , Results.View.root
        ]
