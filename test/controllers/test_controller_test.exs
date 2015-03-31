defmodule Elixre.TestControllerTest do
  use Elixre.ControllerCase, async: true

  import Poison.Parser, only: [parse!: 1]

  @index "/test"

  ############
  #  Params  #
  ############

  with "the index action" do
    with "no subject or regex params" do
      setup context do
        get_index context
      end

      should_respond_with :bad_request

      should "return error with missing params", ctx do
        assert parse!(ctx.connection.resp_body) == %{
          "error" => %{ "missing params" => ["regex", "subject[]"] }
        }
      end
    end

    with "only regex params" do
      setup context do
        params = %{"regex" => "foo"}
        get_index context, params
      end

      should_respond_with :bad_request

      should "return error with the missing subject param", ctx do
        assert parse!(ctx.connection.resp_body) == %{
          "error" => %{ "missing params" => ["subject[]"] }
        }
      end
    end

    with "only subject params" do
      setup context do
        params = %{"subject" => "foo"}
        get_index context, params
      end

      should_respond_with :bad_request

      should "return error with the missing regex param", ctx do
        assert parse!(ctx.connection.resp_body) == %{
          "error" => %{ "missing params" => ["regex"] }
        }
      end
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

      should "return error with reason", ctx do
        assert parse!(ctx.connection.resp_body) == %{
          "error" => ["nothing to repeat", 0]
        }
      end
    end

    with "a valid regex" do
      with "one subject" do
        setup context do
          params = %{"subject" => "foobar", "regex" => "o+(.)?"}
          get_index context, params
        end

        should_respond_with :success

        should "return the results", ctx do
          assert parse!(ctx.connection.resp_body) == %{
            "regex" => "~r/o+(.)?/",
            "results" => [
              %{"subject" => "foobar", "result" => ["oob", "b"]}
            ]
          }
        end
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

        should "return the results", ctx do
          assert parse!(ctx.connection.resp_body) == %{
            "regex" => "~r/(?:f|b)(.+)/",
            "results" => [
              %{"result" => ["foo", "oo"], "subject" => "foo"},
              %{"result" => ["bar", "ar"], "subject" => "bar"},
              %{"result" => ["baz", "az"], "subject" => "baz"}
            ]
          }
        end
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
