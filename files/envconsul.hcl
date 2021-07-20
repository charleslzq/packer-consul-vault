consul {
  address = "127.0.0.1:8500"
}
# This tells Envconsul to not include the parent processes' environment when
# launching the child process.
pristine = true

# This tell Envconsul to remove any non-standard values from environment
# variable keys and replace them with underscores.
sanitize = true

# This tells Envconsul to convert environment variable keys to uppercase (which
# is more common and a bit more standard).
upcase = true

#vault {
#  address = "http://127.0.0.1:8200"
#}
