defmodule Elixre.TestControllerTest do
  use Elixre.ControllerCase, async: true

  @index "/test"

  with "the index action" do
    with "no subject or regex params" do
      setup context do
        post_index context
      end

      should_respond_with :bad_request
      should_return_json_of %{
        "error" => %{ "missing params" => ["regex", "subject[]"] }
      }
    end


    with "only regex params" do
      setup context do
        params = %{"regex" => "foo"}
        post_index context, params
      end

      should_respond_with :bad_request
      should_return_json_of %{
        "error" => %{ "missing params" => ["subject[]"] }
      }
    end


    with "only subject params" do
      setup context do
        params = %{"subject" => "foo"}
        post_index context, params
      end

      should_respond_with :bad_request
      should_return_json_of %{
        "error" => %{ "missing params" => ["regex"] }
      }
    end


    with "both regex and subject params" do
      setup context do
        params = %{"subject" => "foo", "regex" => "bar"}
        post_index context, params
      end

      should_respond_with :success
    end



    with "an invalid regex" do
      setup context do
        params = %{"subject" => "foo", "regex" => "?"}
        post_index context, params
      end

      should_respond_with :success
      should_return_json_of %{
        "error" => ["nothing to repeat", 0]
      }
    end


    with "a valid regex" do
      with "one subject" do
        setup context do
          params = %{"subject" => "foobar", "regex" => "o+(.)?"}
          post_index context, params
        end

        should_respond_with :success
        should_return_json_of %{
          "regex" => "~r/o+(.)?/",
          "results" => [
            %{
              "subject" => "foobar",
              "result" => ["oob", "b"],
              "indexes" => [[1, 3], [3, 1]]
            }
          ]
        }
      end


      with "multiple subjects" do
        setup context do
          params = %{
            "subject" => ["foo", "bar", "baz"],
            "regex" => "(?:f|b)(.+)"
          }
          post_index context, params
        end

        should_respond_with :success
        should_return_json_of %{
          "regex" => "~r/(?:f|b)(.+)/",
          "results" => [
            %{
              "result" => ["foo", "oo"],
              "subject" => "foo",
              "indexes" => [[0, 3], [1, 2]],
            },
            %{
              "result" => ["bar", "ar"],
              "subject" => "bar",
              "indexes" => [[0, 3], [1, 2]],
            },
            %{
              "result" => ["baz", "az"],
              "subject" => "baz",
              "indexes" => [[0, 3], [1, 2]],
            }
          ]
        }
      end


      with "the modifiers param passed" do
        setup context do
          params = %{
            "subject" => ["FOO", "bar", "BAZ"],
            "regex" => "(?:f|b)(.+)",
            "modifiers" => "i"
          }
          post_index context, params
        end

        should_respond_with :success
        should_return_json_of %{
          "regex" => "~r/(?:f|b)(.+)/i",
          "results" => [
            %{
              "result" => ["FOO", "OO"],
              "subject" => "FOO",
              "indexes" => [[0, 3], [1, 2]],
            },
            %{
              "result" => ["bar", "ar"],
              "subject" => "bar",
              "indexes" => [[0, 3], [1, 2]],
            },
            %{
              "result" => ["BAZ", "AZ"],
              "subject" => "BAZ",
              "indexes" => [[0, 3], [1, 2]],
            }
          ]
        }
      end
    end
  end

  defp post_index(context) do
    connection = :post |> conn(@index) |> send_request
    Dict.put context, :connection, connection
  end
  defp post_index(context, params) do
    connection = :post |> conn(@index, params) |> send_request
    Dict.put context, :connection, connection
  end
end
