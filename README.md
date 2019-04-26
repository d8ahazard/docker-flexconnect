FlexConnect - A Helper for Flex TV
 
# [digitalhigh/flexconnect](https://github.com/d8ahazard/docker-flexconnect)

[FlexConnect](http://github.com/d8ahazard/docker-flexconnect) is a python based web application for monitoring, analytics and control of Plex Media Server.


## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.digitalhigh.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `digitalhigh/flexconnect` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |

## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=FlexConnect \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -v <path to data>:/app \
  -v <path to plex data>:/plex \
  --restart unless-stopped \
  --network=host \
  digitalhigh/flexconnect
```


### docker-compose

Compatible with docker-compose v2 schemas.

---
version: "2"
services:
  flexconnect:
    image: digitalhigh/flexconnect
    container_name: flexconnect
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - <path to data>:/app
      - <path to plex data>:/plex
    restart: unless-stopped
    network_mode: "host"
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-v /app` | Contains flexconnect files. |
| `-v /plex` | Map this to Plex data directory - recommended RO. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

Access the webui at `<your-ip>:5667`, for more information check out the wiki on github.