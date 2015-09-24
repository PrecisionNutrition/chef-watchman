# Watchman

Installs [Watchman](https://facebook.github.io/watchman/).

## Configuration

If `node['watchman']['max_users_watches']` is present, the system will
be configured to set `fs.inotify.max_user_watches` to its value.
