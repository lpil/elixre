module View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck, onInput)
import Regex
import SubjectResult
import Types exposing (..)


root : Model -> Html Msg
root model =
    div []
        [ testSection model
        , resultsSection model
        ]


testSection : Model -> Html Msg
testSection model =
    div [ class "inputs" ]
        [ div [] (pattern model.pattern ++ modifiers model.modifiers)
        , div [] (subject model.subject model.splitSubject)
        ]


resultsSection : Model -> Html a
resultsSection model =
    let
        preformatted =
            case model.results of
                Nothing ->
                    []

                Just (OkResult results) ->
                    results
                        |> List.map preformattedSubjectResult
                        |> List.intersperse [ text "\n\n" ]
                        |> List.concat

                Maybe.Just (ErrResult errors) ->
                    formatErrors errors
    in
    div [ class "results" ] [ pre [] preformatted ]


formatErrors : List ErrorResultDetail -> List (Html a)
formatErrors errors =
    let
        fmt =
            \{ detail, message } ->
                "{\"" ++ message ++ "\", " ++ detail ++ "}"

        errorMsgs =
            errors
                |> List.map fmt
                |> String.join "\n"
    in
    [ span [ class "results__error" ]
        [ text ("# Compilation error\n\n" ++ errorMsgs) ]
    ]


preformattedSubjectResult : SubjectResult -> List (Html a)
preformattedSubjectResult subjectResult =
    let
        subjectComment =
            SubjectResult.toHtml subjectResult

        binaryResults =
            subjectResult.binaries
                |> List.map (\s -> "\"" ++ escape s ++ "\"")
                |> String.join ",\n "
    in
    subjectComment
        ++ [ text ("\n\n[" ++ binaryResults ++ "]") ]


escape : String -> String
escape =
    Regex.replace Regex.All
        (Regex.regex "[\n]")
        (\{ match } ->
            case match of
                "\n" ->
                    "\\n"

                _ ->
                    ""
        )


pattern : String -> List (Html Msg)
pattern patternValue =
    [ label [ for "pattern", class "pattern-label" ] [ text "Regex" ]
    , input
        [ name "pattern"
        , class "pattern-input"
        , autofocus True
        , value patternValue
        , onInput PatternChange
        ]
        []
    ]


modifiers : String -> List (Html Msg)
modifiers modifiersValue =
    [ label [ for "modifiers", class "modifiers-label" ] [ text "Modifiers" ]
    , input
        [ name "modifiers"
        , class "modifiers-input"
        , value modifiersValue
        , onInput ModifiersChange
        ]
        []
    ]


subject : String -> Bool -> List (Html Msg)
subject subjectValue splitSubject =
    [ label [ for "subject" ] [ text "Subject" ]
    , textarea
        [ name "subject", rows 5, onInput SubjectChange, value subjectValue ]
        []
    , label [ for "split", class "subject-split" ] [ text "Split on newlines?" ]
    , input
        [ name "split"
        , class "subject-split"
        , type_ "checkbox"
        , checked splitSubject
        , onCheck ToggleSplitSubject
        ]
        []
    ]
