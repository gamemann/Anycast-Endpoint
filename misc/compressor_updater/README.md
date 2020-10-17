# Compressor Updater
## Description
A small Bash script I made to update Compressor's config automatically. This also includes the functionality to check the status of Compressor on all servers specified, restart Compressor, and run custom commands.

## Config
You must add an entry to the Bash array for each server. An example would be like the following:

```bash
declare -a PoPs=(
        "user1@127.0.0.1"
        "user2@server2.local"
)
```

## Usage
The script takes one required argument which is the action and a second optional argument for custom commands.

### Updating Config
Make sure you have a `compressor.conf` file in the same directory as the script and run:

```
./update UPDATE
```

This will replace the `/etc/compressor/compressor.conf` file on the servers listed inside the Bash array with the local `compressor.conf` file and restart the Compressor service.

### Checking Status
If you want to check the status of the Compressor service on all servers, run:

```
./update STATUS
```

### Restarting Compressor
If you want to restart Compressor on all servers without updating the config, run:

```
./update RESTART
```

### Custom Commands
If you want to run a custom command such as `uname -r` on all servers, use `CUSTOM` at the first argument followed by the custom command in single quotes for the second argument. Here's an example:

```
./update CUSTOM 'uname -r'
```

## Credits
* [Christian Deacon](https://github.com/gamemann)