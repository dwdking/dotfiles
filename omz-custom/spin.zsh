if [[ "$HOST" == "$WORK_HOST_NAME" ]]; then
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
      _values "Spin command" "gauth[Manage Google Cloud authentication for spin instances.]" \
      "auth[Authenticate to extra GitHub organizations]" \
      "beta[Toggle on or off a beta feature]" \
      "code[Open instance in Visual Studio Code]" \
      "config[Manage Spin client configuration]" \
      "copy[Copy files to an instance]" \
      "destroy[Destroy an instance]" \
      "doctor[Triage and heal spin instances]" \
      "help[Help about any command]" \
      "list[List all your instances]" \
      "login[Authenticates the Spin client]" \
      "open[Open an instance in your browser]" \
      "open-mobile[Open an instance in your mobile device]" \
      "secrets[Manage automated secrets]" \
      "shell[Connect to an instance via SSH]" \
      "show[Show information about an instance]" \
      "up[Create a new instance]" \
      "version[print the current release name]" \
      "wait[Wait for an instance to be available]" \
      "completion[Generate shell tab completion functions for spin]" \
      "snapshot[Build constellation snapshot]" \
      "create[Create a new instance]" \
      "ls[List all your instances]" \
      "rm[Destroy an instance]" \
      "ssh[Connect to an instance via SSH]" \
      "cp[Copy files to an instance]" \
      "scp[Copy files to an instance]"
      ;;
    args)
      case "$line[1]" in

      gauth)
        _arguments -C "1:Subcommands:->subcmds" "*::arg:->subargs",
        case "$state" in
          subcmds)
            _values 'subcommand' "create-group[Creates a Google Group to use as gcp_group in constellation.yml]" \
                      "copy[Copies Google Cloud credentials into an instance.]"
            ;;
          subargs)
            case "$line[1]" in
              
              create-group)
                _arguments -S \
                '--trace[Print the current trace ID (used for debugging)]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
                ;;
      
              copy)
                _arguments -S \
                '1:Instances:($(_cached-list-instances))' \
                '--trace[Print the current trace ID (used for debugging)]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '(--full)-f[Copy in both user and application default credentials]' '(-f)--full[Copy in both user and application default credentials]' '(--user)-u[Copy in just google user credentials]' '(-u)--user[Copy in just google user credentials]' '(--refresh)-r[Get fresh credentials before copying them in to instance]' '(-r)--refresh[Get fresh credentials before copying them in to instance]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
                ;;
            esac
            ;;
        esac
        ;;

        auth)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        beta)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        code)
          _arguments -S \
          '1:Instances:($(_cached-list-instances) --all)' \
          '--trace[Print the current trace ID (used for debugging)]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '--json[Output in JSON format]' '(--no-wait)-n[Do not wait before attempting to connect]' '(-n)--no-wait[Do not wait before attempting to connect]' '(--show)-s[Print the SSH command instead of running it]' '(-s)--show[Print the SSH command instead of running it]' '--insiders[Use VS Code Insiders instead of stable]' '--new-window[Open in a new window]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '*--wait-for-unit[Wait for systemd units to complete before connecting]:WAIT-FOR-UNIT: ' '--wait-timeout[Time to wait in seconds; -1 to wait indefinitely]:WAIT-TIMEOUT: ' '--user[Log in as a specific user]:USER: ' '--profile[Opens with a specific VSCode profile]:PROFILE: '
          ;;

      config)
        _arguments -C "1:Subcommands:->subcmds" "*::arg:->subargs",
        case "$state" in
          subcmds)
            _values 'subcommand' "set[Set Spin client configuration]" \
                      "get[Get Spin client configuration]"
            ;;
          subargs)
            case "$line[1]" in
              
              set)
                _arguments -S \
                '--trace[Print the current trace ID (used for debugging)]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
                ;;
      
              get)
                _arguments -S \
                '--trace[Print the current trace ID (used for debugging)]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
                ;;
            esac
            ;;
        esac
        ;;

        copy)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--show)-s[Print the SSH command instead of running it]' '(-s)--show[Print the SSH command instead of running it]' '(--latest)-l[Select the most recently-created instance for any empty instance names]' '(-l)--latest[Select the most recently-created instance for any empty instance names]' '(--recursive)-r[Recursively copy entire directories]' '(-r)--recursive[Recursively copy entire directories]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        destroy)
          _arguments -S \
          '1:Instances:($(_cached-list-instances) --all)' \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '(--quiet)-q[Suppress progress output]' '(-q)--quiet[Suppress progress output]' '--suspended[Destroy suspended instances]' '(--confirm)-y[Suppress confirmation prompt]' '(-y)--confirm[Suppress confirmation prompt]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        doctor)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        help)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        list)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--no-header)-H[Do not print the header]' '(-H)--no-header[Do not print the header]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '(--output)-o[Comma-separated list of columns to display]:OUTPUT: ' '(-o)--output[Comma-separated list of columns to display]:OUTPUT: '
          ;;

        login)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '(--mode)-m[Login mode. Available modes: region, cluster]:MODE: ' '(-m)--mode[Login mode. Available modes: region, cluster]:MODE: '
          ;;

        open)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '--trace[Print the current trace ID (used for debugging)]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '--json[Output in JSON format]' '(--no-wait)-n[Do not wait before attempting to connect]' '(-n)--no-wait[Do not wait before attempting to connect]' '--control[Open spin-control for an instance. You can also specify an instance ID, namespace or FQDN (e.g. spin open --control shopify-6jx7)]' '--metrics[Open the metrics dashboard for an instance]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '*--wait-for-unit[Wait for systemd units to complete before connecting]:WAIT-FOR-UNIT: ' '--wait-timeout[Time to wait in seconds; -1 to wait indefinitely]:WAIT-TIMEOUT: '
          ;;

        open-mobile)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '2:Repository:($(_cached-list-repos $words[2]))' \
          '--trace[Print the current trace ID (used for debugging)]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '(--no-wait)-n[Do not wait before attempting to connect]' '(-n)--no-wait[Do not wait before attempting to connect]' '(--shutdown)-s[Shutdown device on error or process termination.]' '(-s)--shutdown[Shutdown device on error or process termination.]' '(--connection-only)-c[Open a connection to the Spin instance metro server without booting a device.]' '(-c)--connection-only[Open a connection to the Spin instance metro server without booting a device.]' '(--force-tunnel)-f[Kills any existing process using port 8081 before opening tunnel to Spin instance.]' '(-f)--force-tunnel[Kills any existing process using port 8081 before opening tunnel to Spin instance.]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '*--wait-for-unit[Wait for systemd units to complete before connecting]:WAIT-FOR-UNIT: ' '--wait-timeout[Time to wait in seconds; -1 to wait indefinitely]:WAIT-TIMEOUT: ' '(--platform)-p[Either '\''ios'\'' or '\''android'\'']:PLATFORM: ' '(-p)--platform[Either '\''ios'\'' or '\''android'\'']:PLATFORM: ' '(--device-id)-d[Simulator udid for '\''ios'\'' and AVD name for
'\''android'\''.]:DEVICE-ID: ' '(-d)--device-id[Simulator udid for '\''ios'\'' and AVD name for
'\''android'\''.]:DEVICE-ID: ' '(--boot-args)-b[Comma separated flag or key-value pairs to send as boot args to the device. Android only. e.g <flag>,<key>:<value>]:BOOT-ARGS: ' '(-b)--boot-args[Comma separated flag or key-value pairs to send as boot args to the device. Android only. e.g <flag>,<key>:<value>]:BOOT-ARGS: ' '(--repo)-r[Repository that contains the React Native project.]:REPO: ' '(-r)--repo[Repository that contains the React Native project.]:REPO: ' '--project-dir[Directory relative to the repository root that contains the React Native project.]:PROJECT-DIR: '
          ;;

      secrets)
        _arguments -C "1:Subcommands:->subcmds" "*::arg:->subargs",
        case "$state" in
          subcmds)
            _values 'subcommand' "create[Create a user global secret shared by all the user instances]" \
                      "destroy[Destroy a previously-created user global secret]"
            ;;
          subargs)
            case "$line[1]" in
              
              create)
                _arguments -S \
                '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--user)-u[A no-op option for backward compatibility]' '(-u)--user[A no-op option for backward compatibility]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
                ;;
      
              destroy)
                _arguments -S \
                '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--user)-u[A no-op option for backward compatibility]' '(-u)--user[A no-op option for backward compatibility]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
                ;;
            esac
            ;;
        esac
        ;;

        shell)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '--trace[Print the current trace ID (used for debugging)]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '--json[Output in JSON format]' '(--no-wait)-n[Do not wait before attempting to connect]' '(-n)--no-wait[Do not wait before attempting to connect]' '(--show)-s[Print the SSH command instead of running it]' '(-s)--show[Print the SSH command instead of running it]' '--recreate-forwardings[Recreate port forwardings]' '--tmux[Start tmux control mode (iTerm2 only)]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '*--wait-for-unit[Wait for systemd units to complete before connecting]:WAIT-FOR-UNIT: ' '--wait-timeout[Time to wait in seconds; -1 to wait indefinitely]:WAIT-TIMEOUT: ' '*-p[Port to forward. \[dir:\]port\[:hostport\]]:PORT-FORWARD: ' '*--port-forward[Port to forward. \[dir:\]port\[:hostport\]]:PORT-FORWARD: '
          ;;

        show)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '(--output)-o[Select just one field to print]:OUTPUT: ' '(-o)--output[Select just one field to print]:OUTPUT: '
          ;;

        up)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--wait)-w[Wait for instance to be available before exiting]' '(-w)--wait[Wait for instance to be available before exiting]' '(--choose-constellation)-C[Choose one of several constellations defined on a given repo, interactively]' '(-C)--choose-constellation[Choose one of several constellations defined on a given repo, interactively]' '(--show)-s[Instead of creating the instance, print the constellation file.]' '(-s)--show[Instead of creating the instance, print the constellation file.]' '--show-spec[Print raw constellation metadata in --show.]' '--skip-dotfiles[Skip dotfiles when creating instance]' '--no-snapshots[Don'\''t use snapshots when creating instance]' '--use-disk-image-build-mode[Use the same boot sequence as for a snapshot build]' '--container-in-vm[Same as --privileged]' '--privileged[Run Isospin as a privileged container in a dedicated VM \[beta\]]' '--vm[Use VM as compute resource \[beta\]]' '--vm-native[alias to `--vm`]' '--shell[Wait for the instance to becoming available then connect with SSH]' '--open[Wait for the instance to becoming available then open the instance URL]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '*--wait-for-unit[Wait for systemd units to complete before connecting]:WAIT-FOR-UNIT: ' '--wait-timeout[Time to wait in seconds; -1 to wait indefinitely]:WAIT-TIMEOUT: ' '*-c[Provide additional configuration for a repo]:CONFIG: ' '*--config[Provide additional configuration for a repo]:CONFIG: ' '*-m[Provide metadata for the instance (prefer -c <repo>.env)]:METADATA: ' '*--metadata[Provide metadata for the instance (prefer -c <repo>.env)]:METADATA: ' '*--secret[Provide secret names for secrets only available for the instance, values will be asked interactively]:SECRET: ' '(--name)-n[Override name of the instance]:NAME: ' '(-n)--name[Override name of the instance]:NAME: ' '--memory[Override memory in GB to use]:MEMORY: ' '--cpu[Override CPU in cores to use]:CPU: ' '--storage[Override RW disk storage size in GB]:STORAGE: ' '--swap[Override swap size in GB]:SWAP: ' '--disk-type[Override RW disk type]:DISK-TYPE: ' '*-l[Provide snapshot image name (layer) to use]:SNAPSHOT: ' '*--snapshot[Provide snapshot image name (layer) to use]:SNAPSHOT: ' '--base[Provide the name of the environment to use as a base for the new instance]:BASE: ' '--region[Provide region to use for the instance]:REGION: ' '(--disk-zone)-z[Provide disk zone to use for the instance]:DISK-ZONE: ' '(-z)--disk-zone[Provide disk zone to use for the instance]:DISK-ZONE: ' '--boot-unit[Override systemd unit to boot into]:BOOT-UNIT: ' '--upload-ejson-keys[Control uploading keys from `/opt/ejson/keys` as secrets prior to creating instance: "force", "lazy", "skip"]:UPLOAD-EJSON-KEYS: '
          ;;

        version)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        wait)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '--trace[Print the current trace ID (used for debugging)]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '--json[Output in JSON format]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '*--wait-for-unit[Wait for systemd units to complete before connecting]:WAIT-FOR-UNIT: ' '--wait-timeout[Time to wait in seconds; -1 to wait indefinitely]:WAIT-TIMEOUT: '
          ;;

        completion)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '(--shell)-s[Shell to generate tab completion for]:SHELL: ' '(-s)--shell[Shell to generate tab completion for]:SHELL: '
          ;;

        snapshot)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '--open[Open the build URL after creation]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '*-c[Provide additional configuration for a repo]:CONFIG: ' '*--config[Provide additional configuration for a repo]:CONFIG: ' '*-m[Provide metadata for the instance (prefer -c <repo>.env)]:METADATA: ' '*--metadata[Provide metadata for the instance (prefer -c <repo>.env)]:METADATA: ' '*--build-env[Set environement variables for the Buildkite build (not the instance itself)]:BUILD-ENV: ' '--mode[Mode of the snapshot (test, production)."production" mode will promote successful snapshots to be used by `spin up`.]:MODE: '
          ;;

        create)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--wait)-w[Wait for instance to be available before exiting]' '(-w)--wait[Wait for instance to be available before exiting]' '(--choose-constellation)-C[Choose one of several constellations defined on a given repo, interactively]' '(-C)--choose-constellation[Choose one of several constellations defined on a given repo, interactively]' '(--show)-s[Instead of creating the instance, print the constellation file.]' '(-s)--show[Instead of creating the instance, print the constellation file.]' '--show-spec[Print raw constellation metadata in --show.]' '--skip-dotfiles[Skip dotfiles when creating instance]' '--no-snapshots[Don'\''t use snapshots when creating instance]' '--use-disk-image-build-mode[Use the same boot sequence as for a snapshot build]' '--container-in-vm[Same as --privileged]' '--privileged[Run Isospin as a privileged container in a dedicated VM \[beta\]]' '--vm[Use VM as compute resource \[beta\]]' '--vm-native[alias to `--vm`]' '--shell[Wait for the instance to becoming available then connect with SSH]' '--open[Wait for the instance to becoming available then open the instance URL]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '*--wait-for-unit[Wait for systemd units to complete before connecting]:WAIT-FOR-UNIT: ' '--wait-timeout[Time to wait in seconds; -1 to wait indefinitely]:WAIT-TIMEOUT: ' '*-c[Provide additional configuration for a repo]:CONFIG: ' '*--config[Provide additional configuration for a repo]:CONFIG: ' '*-m[Provide metadata for the instance (prefer -c <repo>.env)]:METADATA: ' '*--metadata[Provide metadata for the instance (prefer -c <repo>.env)]:METADATA: ' '*--secret[Provide secret names for secrets only available for the instance, values will be asked interactively]:SECRET: ' '(--name)-n[Override name of the instance]:NAME: ' '(-n)--name[Override name of the instance]:NAME: ' '--memory[Override memory in GB to use]:MEMORY: ' '--cpu[Override CPU in cores to use]:CPU: ' '--storage[Override RW disk storage size in GB]:STORAGE: ' '--swap[Override swap size in GB]:SWAP: ' '--disk-type[Override RW disk type]:DISK-TYPE: ' '*-l[Provide snapshot image name (layer) to use]:SNAPSHOT: ' '*--snapshot[Provide snapshot image name (layer) to use]:SNAPSHOT: ' '--base[Provide the name of the environment to use as a base for the new instance]:BASE: ' '--region[Provide region to use for the instance]:REGION: ' '(--disk-zone)-z[Provide disk zone to use for the instance]:DISK-ZONE: ' '(-z)--disk-zone[Provide disk zone to use for the instance]:DISK-ZONE: ' '--boot-unit[Override systemd unit to boot into]:BOOT-UNIT: ' '--upload-ejson-keys[Control uploading keys from `/opt/ejson/keys` as secrets prior to creating instance: "force", "lazy", "skip"]:UPLOAD-EJSON-KEYS: '
          ;;

        ls)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--no-header)-H[Do not print the header]' '(-H)--no-header[Do not print the header]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '(--output)-o[Comma-separated list of columns to display]:OUTPUT: ' '(-o)--output[Comma-separated list of columns to display]:OUTPUT: '
          ;;

        rm)
          _arguments -S \
          '1:Instances:($(_cached-list-instances) --all)' \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '(--quiet)-q[Suppress progress output]' '(-q)--quiet[Suppress progress output]' '--suspended[Destroy suspended instances]' '(--confirm)-y[Suppress confirmation prompt]' '(-y)--confirm[Suppress confirmation prompt]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        ssh)
          _arguments -S \
          '1:Instances:($(_cached-list-instances))' \
          '--trace[Print the current trace ID (used for debugging)]' '(--latest)-l[Select the most recently-created instance]' '(-l)--latest[Select the most recently-created instance]' '--json[Output in JSON format]' '(--no-wait)-n[Do not wait before attempting to connect]' '(-n)--no-wait[Do not wait before attempting to connect]' '(--show)-s[Print the SSH command instead of running it]' '(-s)--show[Print the SSH command instead of running it]' '--recreate-forwardings[Recreate port forwardings]' '--tmux[Start tmux control mode (iTerm2 only)]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]' '*--wait-for-unit[Wait for systemd units to complete before connecting]:WAIT-FOR-UNIT: ' '--wait-timeout[Time to wait in seconds; -1 to wait indefinitely]:WAIT-TIMEOUT: ' '*-p[Port to forward. \[dir:\]port\[:hostport\]]:PORT-FORWARD: ' '*--port-forward[Port to forward. \[dir:\]port\[:hostport\]]:PORT-FORWARD: '
          ;;

        cp)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--show)-s[Print the SSH command instead of running it]' '(-s)--show[Print the SSH command instead of running it]' '(--latest)-l[Select the most recently-created instance for any empty instance names]' '(-l)--latest[Select the most recently-created instance for any empty instance names]' '(--recursive)-r[Recursively copy entire directories]' '(-r)--recursive[Recursively copy entire directories]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;

        scp)
          _arguments -S \
          '--trace[Print the current trace ID (used for debugging)]' '--json[Output in JSON format]' '(--show)-s[Print the SSH command instead of running it]' '(-s)--show[Print the SSH command instead of running it]' '(--latest)-l[Select the most recently-created instance for any empty instance names]' '(-l)--latest[Select the most recently-created instance for any empty instance names]' '(--recursive)-r[Recursively copy entire directories]' '(-r)--recursive[Recursively copy entire directories]' '(--help)-h[Show this help message]' '(-h)--help[Show this help message]'
          ;;
      esac
      ;;
    esac
}
compdef _spin spin
fi
