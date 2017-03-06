module Backend exposing (regexQuery)

import Types exposing (..)
import Http
import Json.Decode as Json
import Json.Encode exposing (encode, string, object, list)


regexQuery : Model -> Cmd Msg
regexQuery model =
    Http.send NewResults <|
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
regexQueryBody { pattern, modifiers, subject, splitSubject } =
    let
        subjects =
            if splitSubject then
                subject |> String.lines |> List.map string
            else
                [ string subject ]
    in
        [ ( "pattern", string pattern )
        , ( "modifiers", string modifiers )
        , ( "subjects", list subjects )
        ]
            |> (\o -> object [ ( "regex", object o ) ])
            |> Http.jsonBody


regexRespDecoder : Json.Decoder RegexResult
regexRespDecoder =
    Json.oneOf [ okRespDecoder, errRespDecoder ]


errRespDecoder : Json.Decoder RegexResult
errRespDecoder =
    let
        errorDecoder =
            Json.map2 ErrorResultDetail
                (Json.index 0 Json.string)
                (Json.index 1 Json.int)
    in
        Json.map ErrResult
            (Json.at [ "regex", "errors" ] (Json.list errorDecoder))


okRespDecoder : Json.Decoder RegexResult
okRespDecoder =
    let
        indexesDecoder =
            Json.map2 RegexIndex
                (Json.index 0 Json.int)
                (Json.index 1 Json.int)

        resultDecoder =
            Json.map3 SubjectResult
                (Json.field "subject" Json.string)
                (Json.field "binaries" (Json.list Json.string))
                (Json.field "indexes" (Json.list indexesDecoder))
    in
        Json.at [ "regex", "results" ] (Json.list resultDecoder)
            |> Json.map OkResult
