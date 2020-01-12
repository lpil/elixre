module SubjectResult exposing (DisplayElement(..), highlightMatch, toHtml)

import Html exposing (Html, span, text)
import Html.Attributes exposing (class)
import List
import Maybe
import Types exposing (..)


type DisplayElement
    = Text String
    | Highlight String


toHtml : SubjectResult -> List (Html a)
toHtml result =
    result
        |> highlightMatch
        |> List.map displayElementToHtml


dropFirstNewline : List DisplayElement -> List DisplayElement
dropFirstNewline elements =
    case elements of
        (Text string) :: rest ->
            Text (String.dropLeft 1 string) :: rest

        _ ->
            elements


displayElementToHtml : DisplayElement -> Html a
displayElementToHtml element =
    case element of
        Text s ->
            text s

        Highlight s ->
            span [ class "hl" ] [ text s ]


highlightMatch : SubjectResult -> List DisplayElement
highlightMatch { subject, indexes } =
    indexes
        |> List.head
        |> Maybe.withDefault { start = 0, length = 0 }
        |> doHighlight (String.lines subject)
        |> dropFirstNewline


doHighlight : List String -> RegexIndex -> List DisplayElement
doHighlight subject { start, length } =
    case ( subject, start ) of
        ( [], _ ) ->
            []

        ( [ "" ], _ ) ->
            []

        ( line :: lines, 0 ) ->
            if String.length line == length then
                -- If the entire line is matched, no more
                let
                    rest =
                        doHighlight lines { start = 0, length = 0 }
                in
                Text "\n# " :: Highlight line :: rest

            else if String.length line <= length then
                -- If the entire line is matched, and more
                let
                    rest =
                        doHighlight lines
                            { start = 0
                            , length = max 0 (length - 1 - String.length line)
                            }
                in
                Text "\n# " :: Highlight line :: rest

            else if length == 0 then
                -- If there is nothing matched
                let
                    rest =
                        doHighlight lines
                            { start = 0
                            , length = 0
                            }
                in
                Text ("\n# " ++ line) :: rest

            else
                -- If the first part of the string is matched
                let
                    match =
                        String.slice 0 length line

                    after =
                        String.slice length (String.length line) line

                    rest =
                        doHighlight lines
                            { start = 0
                            , length = max 0 (start + length - String.length line)
                            }
                in
                Text "\n# " :: Highlight match :: Text after :: rest

        ( line :: lines, _ ) ->
            if String.length line <= start + length - 1 then
                -- If there is some unmatched, the rest of the line is matched
                let
                    before =
                        String.slice 0 start line

                    match =
                        String.slice start (String.length line) line

                    rest =
                        doHighlight lines
                            { start = 0
                            , length = max 0 (start + length - 1 - String.length line)
                            }
                in
                Text ("\n# " ++ before) :: Highlight match :: rest

            else
                -- If there is some unmatched, some matched, and then the rest
                -- of the line is unmatched
                let
                    sliceStart =
                        start - 1

                    before =
                        String.slice 0 sliceStart line

                    match =
                        String.slice sliceStart (sliceStart + length) line

                    after =
                        String.slice (sliceStart + length) (String.length line) line

                    rest =
                        doHighlight lines
                            { start = 0
                            , length = max 0 (start + length - String.length line)
                            }
                in
                Text ("\n# " ++ before) :: Highlight match :: Text after :: rest
