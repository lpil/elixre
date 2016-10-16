module State exposing (..)

import Types exposing (..)


init : Flags -> Model
init flags =
    { regexEndpoint = flags.regexEndpoint
    , queryStatus = NoRequest
    , pattern = ""
    , modifiers = ""
    , subject = "shop"
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PatternChange value ->
            enqueueTestQuery { model | pattern = value }

        ModifiersChange value ->
            enqueueTestQuery { model | modifiers = value }

        SubjectChange value ->
            enqueueTestQuery { model | subject = value }


{-| The server is only hit if a request is not already in progress.
If one is in progress we make note there is a queued request and do
nothing until the response arrives.
-}
enqueueTestQuery : Model -> ( Model, Cmd Msg )
enqueueTestQuery model =
    case model.queryStatus of
        NoRequest ->
            ( model, queryServer model )

        AwaitingResult ->
            ( { model | queryStatus = AwaitingResultWithQueue }, Cmd.none )

        AwaitingResultWithQueue ->
            ( model, Cmd.none )


{-| TODO: Hit server
-}
queryServer : Model -> Cmd Msg
queryServer model =
    Cmd.none
