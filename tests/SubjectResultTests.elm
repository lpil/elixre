module SubjectResultTests exposing (all)

import Expect
import SubjectResult exposing (DisplayElement(Highlight, Text))
import Test exposing (..)


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
                            [ Text "# "
                            , Highlight "Hi"
                            ]
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
                            , Text "\n# "
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
                            , Text "\n# "
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
                            , Text "\n# "
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
                            , Text "\n# "
                            , Highlight "cd"
                            ]
            , test "1:1 subject, 2 match, newline matched" <|
                \() ->
                    { subject = "a\nb"
                    , binaries = []
                    , indexes = [ { start = 0, length = 2 } ]
                    }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            [ Text "# "
                            , Highlight "a"
                            , Text "\n# b"
                            ]
            , test "3:1 subject, 2 match, newline matched" <|
                \() ->
                    { subject = "abc\nd"
                    , binaries = []
                    , indexes = [ { start = 2, length = 2 } ]
                    }
                        |> SubjectResult.highlightMatch
                        |> Expect.equal
                            [ Text "# ab"
                            , Highlight "c"
                            , Text "\n# d"
                            ]
            ]
        ]
