module View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Types exposing (..)
import Regex
import SubjectResult


root : Model -> Html Msg
root model =
    div []
        [ testSection model
        , resultsSection model
        ]


testSection : Model -> Html Msg
testSection model =
    div [ class "inputs" ]
        [ div [] ((pattern model.pattern) ++ (modifiers model.modifiers))
        , div [] (subject model.subject)
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
                        |> List.concatMap preformattedSubjectResult

                Maybe.Just (ErrResult errors) ->
                    Debug.crash "err results rendering"
    in
        div [ class "results" ] [ pre [] preformatted ]


preformattedSubjectResult : SubjectResult -> List (Html a)
preformattedSubjectResult subjectResult =
    let
        subjectComment =
            SubjectResult.toHtml subjectResult

        binaryResults =
            subjectResult.binaries
                |> List.map (\s -> "\"" ++ (escape s) ++ "\"")
                |> String.join "\n "
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



-- <div ng-controller="resultsController" class="results">
--   <pre><div class="results__error"
--             ng-if="return.error"
--             ng-bind="'Compilation Error! \n' + (return.error | json)"></div
--             ><div class="results__regex"
--             ng-if="return.regex"
--             ng-bind="'# ' + return.regex + '\n\n'"></div
--             ><div class="results__result"
--             ng-repeat="case in return.results"
--             ><result data="case"></div></pre>
-- </div>


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


subject : String -> List (Html Msg)
subject subjectValue =
    [ label [ for "subject" ] [ text "Subject" ]
    , textarea
        [ name "subject", rows 5, onInput SubjectChange, value subjectValue ]
        []
    , label [ for "split", class "subject-split" ] [ text "Split on newlines?" ]
    , input
        [ name "split"
        , class "subject-split"
        , type_ "checkbox"
        ]
        []
    ]
