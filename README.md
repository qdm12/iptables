# Iptables Docker

8MB Docker image to run iptables rules.

Built for amd64, 386, ARM and s390x CPU architectures.

## Setup

1. Write your iptables rules in a file *rules.sh*. You might want to make it clear everything at the beginning so you can restart the container easily. For example:

    ```sh
    # Flush the Docker user chain
    iptables -F DOCKER-USER
    # Accept related connections
    iptables -A DOCKER-USER -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    # Limit access for a web server container running on port 8080
    MYLAN=192.168.1.0/24
    WEB_SERVER_CONTAINER=10.0.0.10
    # No outbound connections
    iptables -A DOCKER-USER -s $WEB_SERVER_CONTAINER -j DROP
    # Allow inbound connections from your LAN
    iptables -A DOCKER-USER -d $WEB_SERVER_CONTAINER -s $MYLAN -p tcp --dport 8080 -j ACCEPT
    # Drop inbound connections from your other private IP addresses
    # PRIVATE_IPS is built-in and contains all the private ip addresses
    iptables -A DOCKER-USER -d $WEB_SERVER_CONTAINER -s $PRIVATE_IPS -p tcp --dport 8080 -j DROP
    # Allow inbound connections from public IP addresses
    iptables -A DOCKER-USER -d $WEB_SERVER_CONTAINER -s $PRIVATE_IPS -p tcp --dport 8080 -j ACCEPT
    # Block the rest
    iptables -A DOCKER-USER -d $WEB_SERVER_CONTAINER -j DROP
    ```

1. Run the container (ephemerally) with

    ```sh
    docker run -it --rm --cap-add=NET_ADMIN --net=host -v /yourpath/rules.sh:/rules.sh:ro qmcgaw/iptables
    ```

    You can also use `docker-compose up` with the [docker-compose.yml](https://raw.githubusercontent.com/qdm12/iptables/master/docker-compose.yml) file.

## Suggestions

👉 [Create an issue](https://github.com/qdm12/iptables/issues/new)

## License

License is of course an MIT license

## TODOs

- Get microbadger webhook link
