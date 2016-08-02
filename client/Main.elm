module Main exposing (..)

import Html exposing (..)
import Html.App as Html
import Input.View
import Results.View
import Input.State


main : Program Flags
main =
    Html.programWithFlags
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }


type alias Model =
    { inputModel : Input.State.Model
    }


type alias Flags =
    { regexEndpoint : Input.State.EndpointUrl
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { inputModel = Input.State.init flags.regexEndpoint
      }
    , Cmd.none
    )


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
        [ Input.View.root model.inputModel
        , Results.View.root
        ]
