# Build AUR packages on Docker.


## Quickstart
```
docker build -t denbeigh2000/arch-docker .
mkdir -p out && chmod 777 out
docker run --rm \
    -v out:/out \
    -e PKG_NAME=my-aur-package \
    denbeigh2000/arch-docker
```

## What is this?

This allows you to easily clone, build and compress a package from the
[Arch User Repository](https://aur.archlinux.org/).

It will also try to find all `make` commands and add additional concurrency,
because this is about going fast. It uses a regular expression, so it may ruin
your day at some point, but it's worked pretty well for me.

## Why did you do this?

This arose from a one-time use case where I wanted to compile an AUR package,
but didn't have enough resources to do it in a reasonable amount of time. I've
been using it for a few months now to build AUR packages into `.tar.xz` files
and install them with `pacman` on multiple omputers.

You could also use this for some kind of development, testing or continuous
integration purposes, I guess.

## How do I use this?

 - Mount a permissive directory to `/out` in the container (see quickstart).
     The directory must have generous write permissions to allow writing from the
     unprivileged container user.
 - Set the `PKG_NAME` environment variable to the AUR package name of your
     choice.
 - (Optional) To change the concurrency, override the `CONCURRENCY` variable.
     If unset, this will use the number of cores visible to the container.
