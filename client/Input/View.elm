module Input.View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Input.State exposing (Model, Msg(PatternChange))


root : Model -> Html Msg
root model =
    div [ class "inputs" ]
        [ div [] ((pattern model.pattern) ++ (modifiers model.modifiers))
        , div [] subject
        ]


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


modifiers : String -> List (Html a)
modifiers modifiersValue =
    [ label [ for "modifiers", class "modifiers-label" ] [ text "Modifiers" ]
    , input [ name "modifiers", class "modifiers-input" ] []
    ]


subject : List (Html a)
subject =
    [ label [ for "subject" ] [ text "Subject" ]
    , textarea [ name "subject", rows 5 ] []
    , label [ for "split", class "subject-split" ] [ text "Split on newlines?" ]
    , input [ name "split", class "subject-split", type' "checkbox" ] []
    ]
