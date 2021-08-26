# Docker Example

Here is a fast and easy way to create and deploy several trading bots with minimal effort.

## Setup:

In the `docker-compose.yml` file you will find a fairly simple docker compose setup.

Here is the file contents for reference:

```yaml
version: "3.9"
services:
    btc-trader:
        image: ghcr.io/dylanbulmer/crypfinder:latest
        env_file:
            - ./.btc.env
        volumes:
            - btc:/usr/src/data/
    doge-trader:
        image: ghcr.io/dylanbulmer/crypfinder:latest
        env_file:
            - ./.doge.env
        volumes:
            - doge:/usr/src/data/

networks:
    default:
        external: false
        name: crypfinder_default

volumes:
    btc:
        external: false
        name: crypfinder_btc
    doge:
        external: false
        name: crypfinder_doge
```

<br/>

## Version:

```yaml
version: "3.9"
```

Specifies the docker compose version.

<br/>

## Services:

Each service specifies an image, environment variable file, and a volume.

| Parameter  | Description                                                                                |
| :--------- | :----------------------------------------------------------------------------------------- |
| `image`    | The docker image location and version.                                                     |
| `env_file` | An array of environment variable file locations relative to the `docker-compose.yml` file. |
| `volumes`  | An array of volume names mapped to the location within the docker container.               |

### Example:

```yaml
btc-trader:
    image: ghcr.io/dylanbulmer/crypfinder:latest
    env_file:
        - ./.btc.env
    volumes:
        - btc:/usr/src/data/
```

This example showcases a simple Bitcoin trader deployment. We are grabbing the latest image of `CrypFinder`, applying the environment variables for our BTC Trader API key, and attaching a volume to the data folder to ensure the position data persists between restarts.

<br/>

## Networks:

An array of networks for the services to use. Every service in a deployment automatically gets assigned a `default` network that is separate from other deployment unless specified otherwise in the service definition.

### Example:

```yaml
networks:
    default:
        external: false
        name: crypfinder_default
```

For this deployment we are naming the default network `crypfinder_default`, this way when running `docker network ls` we can distinguish the different networks.

If wanted, you can create and use an external network, but it would be useless for this service.

<br/>

## Volumes:

An array of volume names. Volumes are used to persist data across restarts.

### Example:

```yaml
volumes:
    btc:
        external: false
        name: crypfinder_btc
    doge:
        external: false
        name: crypfinder_doge
```

This example is specifying two volumes. During first deployment two volumes will be created `crypfinder_btc` and `crypfinder_doge`.

If desired, you can create external volumes and set `external` to `true`.
