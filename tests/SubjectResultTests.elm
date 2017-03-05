module SubjectResultTests exposing (..)

import Test exposing (..)
import Expect
import SubjectResult exposing (DisplayElement(Text, Highlight))


all : Test
all =
    describe "SubjectResultTests"
        [ describe "highlightMatch"
            [ test "Empty subject" <|
                \() ->
                    { subject = "", binaries = [], indexes = [] }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            []
            , test "Subject, no indexes" <|
                \() ->
                    { subject = "Hello", binaries = [], indexes = [] }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            [ Text "# Hello" ]
            , test "match entire subject" <|
                \() ->
                    { subject = "Hi"
                    , binaries = []
                    , indexes = [ { start = 0, length = 2 } ]
                    }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            [ Text "# ", Highlight "Hi" ]
            , test "match entire subject, subject has newlines" <|
                \() ->
                    { subject = "Hi,\nworld!"
                    , binaries = []
                    , indexes = [ { start = 0, length = 20 } ]
                    }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            [ Text "# "
                            , Highlight "Hi,"
                            , Text "# "
                            , Highlight "world!"
                            ]
            , test "match start of subject" <|
                \() ->
                    { subject = "abc"
                    , binaries = []
                    , indexes = [ { start = 0, length = 2 } ]
                    }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            [ Text "# "
                            , Highlight "ab"
                            , Text "c"
                            ]
            , test "match half way through a subject" <|
                \() ->
                    { subject = "abcd"
                    , binaries = []
                    , indexes = [ { start = 2, length = 2 } ]
                    }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            [ Text "# a"
                            , Highlight "bc"
                            , Text "d"
                            ]
            , test "match half way through a subject, over multiple lines" <|
                \() ->
                    { subject = "ab\ncd"
                    , binaries = []
                    , indexes = [ { start = 1, length = 3 } ]
                    }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            [ Text "# a"
                            , Highlight "b"
                            , Text "# "
                            , Highlight "c"
                            , Text "d"
                            ]
            , test "match half way to end, over multiple lines" <|
                \() ->
                    { subject = "ab\ncd"
                    , binaries = []
                    , indexes = [ { start = 1, length = 4 } ]
                    }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            [ Text "# a"
                            , Highlight "b"
                            , Text "# "
                            , Highlight "cd"
                            ]
            , test "full match, multi line" <|
                \() ->
                    { subject = "ab\ncd"
                    , binaries = []
                    , indexes = [ { start = 0, length = 5 } ]
                    }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            [ Text "# "
                            , Highlight "ab"
                            , Text "# "
                            , Highlight "cd"
                            ]
            ]
        ]
