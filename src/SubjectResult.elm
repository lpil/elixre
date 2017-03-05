module SubjectResult exposing (DisplayElement(..), highlightMatch)

import List
import Maybe
import Types exposing (..)


type DisplayElement
    = Text String
    | Highlight String


highlightMatch : SubjectResult -> List DisplayElement
highlightMatch { subject, indexes } =
    indexes
        |> List.head
        |> Maybe.withDefault { start = 0, length = 0 }
        |> doHighlight (String.lines subject)


doHighlight : List String -> RegexIndex -> List DisplayElement
doHighlight subject { start, length } =
    case ( subject, start ) of
        ( [], _ ) ->
            []

        ( [ "" ], _ ) ->
            []

        ( line :: lines, 0 ) ->
            if String.length line <= length then
                -- If the entire line is matched
                let
                    rest =
                        doHighlight lines
                            { start = 0
                            , length = max 0 (length - String.length line)
                            }
                in
                    Text "# " :: Highlight line :: rest
            else if length == 0 then
                -- If there is nothing matched
                let
                    rest =
                        doHighlight lines
                            { start = 0
                            , length = 0
                            }
                in
                    Text ("# " ++ line) :: rest
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
                    Text "# " :: Highlight match :: Text after :: rest

        ( line :: lines, _ ) ->
            if String.length line <= start + length - 1 then
                -- If there is some unmatched, the rest of the line is matched
                let
                    before =
                        String.slice 0 start line

                    match =
                        String.slice start length line

                    rest =
                        doHighlight lines
                            { start = 0
                            , length = max 0 (start + length - 1 - String.length line)
                            }
                in
                    Text ("# " ++ before) :: Highlight match :: rest
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
                    Text ("# " ++ before) :: Highlight match :: Text after :: rest
