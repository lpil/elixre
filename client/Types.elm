module Types exposing (..)


type Msg
    = PatternChange String
    | ModifiersChange String
    | SubjectChange String


type RequestStatus
    = NoRequest
    | AwaitingResult
    | AwaitingResultWithQueue


type alias Model =
    { regexEndpoint : String
    , queryStatus : RequestStatus
    , pattern : String
    , modifiers : String
    , subject : String
    }


type alias Flags =
    { regexEndpoint : String
    }
