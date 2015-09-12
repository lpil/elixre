use Mix.Config

random_64_char_string = 64
                        |> :crypto.strong_rand_bytes
                        |> :base64.encode_to_string
                        |> to_string
                        |> String.slice(0, 64)

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :elixre, Elixre.Endpoint,
  secret_key_base: random_64_char_string
