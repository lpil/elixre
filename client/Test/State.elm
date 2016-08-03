module Test.State exposing (..)


type alias EndpointUrl =
    String


type Msg
    = PatternChange String
    | ModifiersChange String
    | SubjectChange String


type alias Model =
    { regexEndpoint : EndpointUrl
    , pattern : String
    , modifiers : String
    , subject : String
    }


init : EndpointUrl -> Model
init url =
    { regexEndpoint = url
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
