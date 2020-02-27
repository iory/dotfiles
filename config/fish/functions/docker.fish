abbr -a "d" docker

# Get the latest container ID
abbr -a dl "docker ps --latest --quiet"

# List containers
abbr -a dps "docker ps"

# List containers including stopped containers
abbr -a dpa "docker ps --all"

# List images
abbr -a di "docker images"

# List images including intermediates
abbr -a dia "docker images --all"

# Get an IPaddress of a container
abbr -a dip "docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run a daemonized container
abbr -a drd "docker run --detach --publish-all"

# Run an interactive container
abbr -a dri "docker run --interactive --tty --publish-all"

# Remove all containers
abbr -a drm 'docker rm (docker ps --all --quiet)'

# Remove none
abbr -a drmn 'docker rmi (docker images -f "dangling=true" -q)'

# Remove all images
abbr -a drmi 'docker rmi $(docker images --quiet)'

# Remove all containers and images by force
abbr -a dclean 'docker kill $(docker ps --all --quiet); drm; drmi;'
