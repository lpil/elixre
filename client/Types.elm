module Types exposing (..)


type alias Model =
    { regexEndpoint : String
    , pattern : String
    , modifiers : String
    , subject : String
    }


type alias Flags =
    { regexEndpoint : String
    }


type Msg
    = PatternChange String
    | ModifiersChange String
    | SubjectChange String
