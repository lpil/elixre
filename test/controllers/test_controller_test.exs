defmodule Elixre.TestControllerTest do
  use Elixre.ControllerCase, async: true

  @index "/test"

  with "the index action" do
    with "no subject or regex params" do
      setup context do
        get_index context
      end

      should_respond_with :bad_request
      should_return_json_of %{
        "error" => %{ "missing params" => ["regex", "subject[]"] }
      }
    end


    with "only regex params" do
      setup context do
        params = %{"regex" => "foo"}
        get_index context, params
      end

      should_respond_with :bad_request
      should_return_json_of %{
        "error" => %{ "missing params" => ["subject[]"] }
      }
    end


    with "only subject params" do
      setup context do
        params = %{"subject" => "foo"}
        get_index context, params
      end

      should_respond_with :bad_request
      should_return_json_of %{
        "error" => %{ "missing params" => ["regex"] }
      }
    end


    with "both regex and subject params" do
      setup context do
        params = %{"subject" => "foo", "regex" => "bar"}
        connection = conn(:post, @index, params) |> send_request
        Dict.put context, :connection, connection
      end

      should_respond_with :success
    end



    with "an invalid regex" do
      setup context do
        params = %{"subject" => "foo", "regex" => "?"}
        get_index context, params
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
          get_index context, params
        end

        should_respond_with :success
        should_return_json_of %{
          "regex" => "~r/o+(.)?/",
          "results" => [
            %{"subject" => "foobar", "result" => ["oob", "b"]}
          ]
        }
      end


      with "multiple subjects" do
        setup context do
          params = %{
            "subject" => ["foo", "bar", "baz"],
            "regex" => "(?:f|b)(.+)"
          }
          get_index context, params
        end

        should_respond_with :success
        should_return_json_of %{
          "regex" => "~r/(?:f|b)(.+)/",
          "results" => [
            %{"result" => ["foo", "oo"], "subject" => "foo"},
            %{"result" => ["bar", "ar"], "subject" => "bar"},
            %{"result" => ["baz", "az"], "subject" => "baz"}
          ]
        }
      end


      with "the options param passed" do
        setup context do
          params = %{
            "subject" => ["FOO", "bar", "BAZ"],
            "regex" => "(?:f|b)(.+)",
            "options" => "i"
          }
          get_index context, params
        end

        should_respond_with :success
        should_return_json_of %{
          "regex" => "~r/(?:f|b)(.+)/i",
          "results" => [
            %{"result" => ["FOO", "OO"], "subject" => "FOO"},
            %{"result" => ["bar", "ar"], "subject" => "bar"},
            %{"result" => ["BAZ", "AZ"], "subject" => "BAZ"}
          ]
        }
      end
    end
  end

  defp get_index(context) do
    connection = conn(:post, @index) |> send_request
    Dict.put context, :connection, connection
  end
  defp get_index(context, params) do
    connection = conn(:post, @index, params) |> send_request
    Dict.put context, :connection, connection
  end
end
