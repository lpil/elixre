module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Types exposing (..)
import Results.View
import Test.State
import Test.View


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
    ( { testModel = Test.State.init flags.regexEndpoint }
    , Cmd.none
    )


subscriptions : Model -> Sub a
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TestMsg subMsg ->
            let
                ( testModel, cmd ) =
                    Test.State.update subMsg model.testModel
            in
                ( { model | testModel = testModel }, Cmd.map TestMsg cmd )


view : Model -> Html Msg
view model =
    div []
        [ App.map TestMsg (Test.View.root model.testModel)
        , Results.View.root
        ]
