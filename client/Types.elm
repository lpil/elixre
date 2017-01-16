module Types exposing (..)

import Http


type Msg
    = PatternChange String
    | ModifiersChange String
    | SubjectChange String
    | ServerRegexResult (Result Http.Error RegexResultData)


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


type alias RegexResultData =
    { validRegex : Bool
    , results : List SingleRegexResultData
    }


type alias SingleRegexResultData =
    { subject : String
    , binaries : List String
    , indexes : List ( Int, Int )
    }
