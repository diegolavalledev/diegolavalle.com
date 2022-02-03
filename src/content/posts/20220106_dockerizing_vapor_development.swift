let post_20220106_dockerizing_vapor_development = Post("/posts/2022-01-06-dockerizing-vapor-development", "Dockerizing Vapor Development", .none, "DL", "2022-01-06T12:00:00Z", (.swiftServerSide, .devOps), ["Docker", "Vapor", "Swift", "Linux"], discussion: 5) { """

Personally I find the use of Docker in development environments quite advantageous. From the get-go it lets me keep my workstation clean of any additional software that I might not even need after a certain while. In addition to that, crafting my own `Dockerfile`s helps me understand a particular tool's requirements and isolate its dependencies. For this reason I knew Docker was the way to go for experimenting with [Vapor](https://vapor.codes) for the very first time.

As base I chose Swift's official [Docker image](https://hub.docker.com/_/swift) which is itself based on Ubuntu. I selected the latest version at the time of writing since I wanted to take advantage of the latest concurrency features and see how nice they play with Vapor and its associated database framework [Fluent](https://docs.vapor.codes/4.0/fluent/overview/).

With a single command we can start a shell using the aforementioned image, mapping a web service port to our machine.

```
docker run --rm -it --name vapor -p 8080:8080 swift:5.5.2
```

From here it turns out that in order to install Vapor, `sudo` is the only missing package. After that we can go ahead and grab the Vapor Toolbox using Git.

```sh
apt-get update
apt-get install sudo
cd /opt
git clone -b 18.3.3 https://github.com/vapor/toolbox.git vapor-toolbox
cd vapor-toolbox
make install
```

Now we are finally ready to use the `vapor` command and bootstrap a simple project.

```sh
vapor new hello -n --no-commit
cd hello
vapor run serve -H 0.0.0.0
```

To see that our command worked and that we have a web site published we just point our browser to `http://localhost:8080` and verify that we can see the default greeting.

We are ready to add Fluent to the mix and set up database capabilities. We will need to install SQLite onto our container first, then reissue the new command with some additional flags.

```sh
apt-get install libsqlite3-dev
vapor new hello-data --fluent.db sqlite --leaf --no-commit
cd hello-data
vapor run migrate
vapor run serve -H 0.0.0.0
```

On the host we can use cURL to issue some HTTP requests. We will query a list of to-do tasks and post a new entry.

```sh
curl http://localhost:8080/todos
curl -X POST http://localhost:8080/todos/ -H "Content-Type: application/json" -d '{"title": "Write a tutorial"}'
# {"title":"Write a tutorial","id":"060FD15C-7EB8-498D-8C3A-E7E1214583CB"}
```

Everything looks great! Time to document all the steps taken so far by writing a proper `Dockerfile`.

```
FROM swift:5.5.2
LABEL Description="Docker Container for Vapor"

RUN apt-get update && \\
    apt-get install sudo libsqlite3-dev && \\
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN \\
    git clone -b 18.3.3 https://github.com/vapor/toolbox.git vapor-toolbox && \\
    cd vapor-toolbox && \\
    make install

VOLUME /root/sandbox
EXPOSE 8080

WORKDIR /root/sandbox
```

We can build our image only once and use it as a sandbox for all of our experiments and projects. Remember to always map a port and a local volume so we can test and edit files directly from the host.

```sh
docker build -t vapor .
docker run --rm -it --name vapor -v $PWD:/root/sandbox -p 8080:8080 vapor
```

The full code from this article can be found on this [GitHub repository](https://github.com/helowrld/docker-vapor-dev). You are welcome to leave a comment below in the discussion.

""" } summary: { """
Create a sandbox for your Vapor project complete with SQLite support. All using the power of Docker.
""" }
