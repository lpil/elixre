module Input.View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)


root : Html a
root =
    div [ class "inputs" ]
        [ div [] (pattern ++ modifiers)
        , div [] subject
        ]


pattern : List (Html a)
pattern =
    [ label [ for "regex", class "regex-label" ] [ text "Regex" ]
    , input [ name "regex", class "regex-input", autofocus True ] []
    ]


modifiers : List (Html a)
modifiers =
    [ label [ for "modifiers", class "modifiers-label" ] [ text "Modifiers" ]
    , input [ name "modifiers", class "modifiers-input", autofocus True ] []
    ]


subject : List (Html a)
subject =
    [ label [ for "subject" ] [ text "Subject" ]
    , textarea [ name "subject", rows 5 ] []
    , label [ for "split", class "subject-split" ] [ text "Split on newlines?" ]
    , input [ name "split", class "subject-split", type' "checkbox" ] []
    ]
