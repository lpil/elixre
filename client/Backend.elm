module Backend exposing (regexQuery)

import Types exposing (..)
import Http
import Json.Decode as Json
import Json.Encode exposing (encode, string, object, list)


regexQuery : Model -> Cmd Msg
regexQuery model =
    Http.send ServerRegexResult <|
        Http.post
            model.regexEndpoint
            (regexQueryBody model)
            regexRespDecoder


{-| Request JSON body:
   {
       "regex": {
       "pattern": "foo",
       "modifiers": "iu",
       "subjects": [ "foobarfoo", "FOOBAR", "barfoo" ]
       }
   }
-}
regexQueryBody : Model -> Http.Body
regexQueryBody { pattern, modifiers, subject } =
    [ ( "pattern", string pattern )
    , ( "modifiers", string modifiers )
    , ( "subjects", list [ string subject ] )
    ]
        |> (\o -> object [ ( "regex", object o ) ])
        |> Http.jsonBody


regexRespDecoder : Json.Decoder RegexResultData
regexRespDecoder =
    let
        binaryDecoder =
            Json.map2 (,)
                (Json.index 0 Json.int)
                (Json.index 1 Json.int)

        resultDecoder =
            Json.map3 SingleRegexResultData
                (Json.field "subject" Json.string)
                (Json.field "binaries" (Json.list Json.string))
                (Json.field "binaries" (Json.list binaryDecoder))
    in
        Json.map2 RegexResultData
            (Json.at [ "regex", "valid_regex" ] Json.bool)
            (Json.at [ "regex", "results" ] (Json.list resultDecoder))
