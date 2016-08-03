module Input.State
    exposing
        ( EndpointUrl
        , Model
        , Msg(PatternChange, ModifiersChange)
        , init
        )


type alias EndpointUrl =
    String


type Msg
    = PatternChange String
    | ModifiersChange String


type alias Model =
    { regexEndpoint : EndpointUrl
    , pattern : String
    , modifiers : String
    }


init : EndpointUrl -> Model
init url =
    { regexEndpoint = url
    , pattern = ""
    , modifiers = ""
    }
