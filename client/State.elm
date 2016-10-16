module State exposing (..)

import Types exposing (..)


init : Flags -> Model
init flags =
    { regexEndpoint = flags.regexEndpoint
    , pattern = ""
    , modifiers = ""
    , subject = "shop"
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PatternChange value ->
            ( { model | pattern = value }, Cmd.none )

        ModifiersChange value ->
            ( { model | modifiers = value }, Cmd.none )

        SubjectChange value ->
            ( { model | subject = value }, Cmd.none )
