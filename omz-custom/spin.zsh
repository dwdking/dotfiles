if [[ "$HOST" == "Dans-MacBook-Pro-2.local" ]]; then
_spin() {

  # zsh function that generates spin instance names as autocomplete options
# - gets spin instances with spin list
#
_list-instances-verbose() {
  # Use -H to skip header row.
  spin list -H --output name,age,status,repositories 2> /dev/null \
      | awk -F" " '{print $1"["$2" "$3" "$4"]"}'
}
_list-instances-terse() {
  # Eat the trailing space
  spin list -H --output name 2> /dev/null | cut -f1
}

_cached-list-instances() {
  # Cache hosts for up to an hour. Not using the full _cache_policy feature.
  key=$(date +spin-instances-%Y%m%d%H)
  # Zsh cache boilerplate
  if _cache_invalid $key || ! _retrieve_cache $key; then
    insts=$(_list-instances-terse)
    if [ $? -eq 0 ]; then
      _store_cache $key insts
    else
      insts=""
    fi
  else
    _retrieve_cache $key
  fi

  echo $insts
}

_list-repos-ruby() {
  spin show "$1" --json | \
  ruby -rJSON -e 'puts JSON.load(STDIN)["repos"].map { |r| r["name"].gsub(/^shopify--/, "")}'
}

_cached-list-repos() {
  key=$(date +spin-repos-$1-%Y%m%d%H)
  if _cache_invalid $key || ! _retrieve_cache $key; then
    repos=$(_list-repos-ruby $1)
    if [ $? -eq 0 ]; then
      _store_cache $key repos
    else
      repos=""
    fi
  else
    _retrieve_cache $key
  fi

  echo $repos
}

  # magic invocation that makes the case command below work
  local line state
  _arguments -C "1:Commands:->cmds" "*::arg:->args"

  case "$state" in
    cmds)
      _values "Spin command" "auth[Authenticate to extra GitHub organizations]" \
      "beta[Toggle on or off a beta feature]" \
      "code[Open instance in Visual Studio Code]" \
      "destroy[Destroy an instance]" \
      "help[Help about any command]" \
      "list[List all your instances]" \
      "login[Authenticates the Spin client]" \
      "open[Open an instance in your browser]" \
      "secrets[Manage automated secrets]" \
      "shell[Connect to an instance via SSH]" \
      "show[Show information about an instance]" \
      "up[Create a new instance]" \
      "version[print the current release name]" \
      "wait[Wait for an instance to be available]" \
      "ls[List all your instances]" \
      "ssh[Connect to an instance via SSH]"
      ;;
    args)
      case "$line[1]" in

        auth)
          _arguments -S \
          '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        beta)
          _arguments -S \
          '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        code)
          _arguments -S \
          '1:Instances:($(_cached-list-instances) --all)' \
          '2:Repository:($(_cached-list-repos $words[2]))' \
          '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '--json[Output in JSON format]' '(--no-wait)-n[Do not wait before attempting to connect]' '(-n)--no-wait[Do not wait before attempting to connect]' '--insiders[Use VS Code Insiders instead of stable]' '--new-window[Open in a new window]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        destroy)
          _arguments -S \
          '1:Instances:($(_cached-list-instances) --all)' \
          '--json[Output in JSON format]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '(--quiet)-q[Suppress progress output]' '(-q)--quiet[Suppress progress output]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        help)
          _arguments -S \
          '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        list)
          _arguments -S \
          '--json[Output in JSON format]' '(--no-header)-H[Do not print the header]' '(-H)--no-header[Do not print the header]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '(--output)-o[Comma-separated list of columns to display]:OUTPUT: ' '(-o)--output[Comma-separated list of columns to display]:OUTPUT: '
          ;;

        login)
          _arguments -S \
          '--json[Output in JSON format]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        open)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '--json[Output in JSON format]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

      secrets)
        _arguments -C "1:Subcommands:->subcmds" "*::arg:->subargs",
        case "$state" in
          subcmds)
            _values 'subcommand' "destroy[Destroy a previously-created secret]" \
                      "create[Create a secret to automate setup for a repository]"
            ;;
          subargs)
            case "$line[2]" in

              destroy)
                _arguments -S \
                '--json[Output in JSON format]' '(--user)-u[Create a user secret]' '(-u)--user[Create a user secret]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
                ;;

              create)
                _arguments -S \
                '--json[Output in JSON format]' '(--user)-u[Create a user secret]' '(-u)--user[Create a user secret]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
                ;;
            esac
            ;;
        esac
        ;;

        shell)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '--json[Output in JSON format]' '(--no-wait)-n[Do not wait before attempting to connect]' '(-n)--no-wait[Do not wait before attempting to connect]' '(--show)-s[Print the SSH command instead of running it]' '(-s)--show[Print the SSH command instead of running it]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        show)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '--json[Output in JSON format]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '(--output)-o[Select just one field to print]:OUTPUT: ' '(-o)--output[Select just one field to print]:OUTPUT: '
          ;;

        up)
          _arguments -S \
          '--json[Output in JSON format]' '(--choose-constellation)-C[Choose one of several constellations defined on a given repo, interactively]' '(-C)--choose-constellation[Choose one of several constellations defined on a given repo, interactively]' '(--show)-s[Instead of creating the instance, print the constellation file.]' '(-s)--show[Instead of creating the instance, print the constellation file.]' '(--wait)-w[Wait for instance to be available before exiting]' '(-w)--wait[Wait for instance to be available before exiting]' '--skip-dotfiles[Skip dotfiles when creating instance]' '--no-snapshots[Dont use snapshots when creating instancet use snapshots when creating instance]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '*-c[Provide additional configuration for a repo]:CONFIG: ' '*--config[Provide additional configuration for a repo]:CONFIG: ' '*-m[Provide metadata for the instance (prefer -c <repo>.env)]:METADATA: ' '*--metadata[Provide metadata for the instance (prefer -c <repo>.env)]:METADATA: ' '(--name)-n[Override name of the instance]:NAME: ' '(-n)--name[Override name of the instance]:NAME: '
          ;;

        version)
          _arguments -S \
          '--json[Output in JSON format]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        wait)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '--json[Output in JSON format]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        ls)
          _arguments -S \
          '--json[Output in JSON format]' '(--no-header)-H[Do not print the header]' '(-H)--no-header[Do not print the header]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '(--output)-o[Comma-separated list of columns to display]:OUTPUT: ' '(-o)--output[Comma-separated list of columns to display]:OUTPUT: '
          ;;

        ssh)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '--json[Output in JSON format]' '(--no-wait)-n[Do not wait before attempting to connect]' '(-n)--no-wait[Do not wait before attempting to connect]' '(--show)-s[Print the SSH command instead of running it]' '(-s)--show[Print the SSH command instead of running it]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;
      esac
      ;;
    esac
}
compdef _spin spin
fi
