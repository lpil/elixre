module State exposing (..)

import Types exposing (..)
import Backend
import Http


init : Flags -> Model
init flags =
    { regexEndpoint = flags.regexEndpoint
    , queryStatus = NoRequest
    , pattern = ""
    , modifiers = ""
    , subject = "shop"
    , results = Nothing
    , splitSubject = True
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

        ToggleSplitSubject split ->
            enqueueTestQuery { model | splitSubject = split }

        NewResults result ->
            handleResults result model


{-| The server is only hit if a request is not already in progress.
If one is in progress we make note there is a queued request and do
nothing until the response arrives.
-}
enqueueTestQuery : Model -> ( Model, Cmd Msg )
enqueueTestQuery model =
    case model.queryStatus of
        NoRequest ->
            model ! [ Backend.regexQuery model ]

        AwaitingResult ->
            { model | queryStatus = AwaitingResultWithQueue } ! []

        AwaitingResultWithQueue ->
            model ! []


handleResults : Result Http.Error RegexResult -> Model -> ( Model, Cmd Msg )
handleResults result model =
    case result of
        Ok results ->
            { model | queryStatus = NoRequest, results = Just results } ! []

        Err x ->
            let
                _ =
                    Debug.crash "Err" x
            in
                { model | queryStatus = NoRequest } ! []
