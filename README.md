Buildpack: Scala
================

This is a [Buildpack](http://doc.scalingo.com/buildpacks) for Scala apps.
It uses [sbt](https://github.com/harrah/xsbt/) 0.11.0+.

Usage
-----

Example usage:

    $ ls
    Procfile build.sbt project src

    $ scalingo create scala-app

    $ git push scalingo master
    ...
    -----> Scala app detected
    -----> Building app with sbt
    -----> Running: sbt compile stage

The buildpack will detect your app as Scala if it has the project/build.properties and either .sbt or .scala based build config.  It vendors a version of sbt and your popluated .ivy/cache into your container.  The .ivy2 directory will be cached between builds to allow for faster build times.

Clean builds
------------

In some cases, builds need to clean artifacts before compiling. If a clean build is necessary, configure builds to perform clean by setting `SBT_CLEAN=true`:

```sh-session
$ scalingo env-set SBT_CLEAN=true
SBT_CLEAN has been set to true.
```

All subsequent deploys will use the clean task. To remove the clean task, unset `SBT_CLEAN`:

```sh-session
$ scalingo env-unset SBT_CLEAN
SBT_CLEAN has been unset.
```

Hacking
-------

To use this buildpack, fork it on Github.  Push up changes to your fork, then create a test app with `--buildpack <your-github-url>` and push to it.

For example, to reduce your container size by not including the .ivy2/cache, you could add the following.

    for DIR in $CACHED_DIRS ; do
    rm -rf $CACHE_DIR/$DIR
    mkdir -p $CACHE_DIR/$DIR
    cp -r $DIR/.  $CACHE_DIR/$DIR
    # The following 2 lines are what you would add
    echo "-----> Dropping ivy cache from the container"
    rm -rf $SBT_USER_HOME/.ivy2

Note: You will need to have your build copy the necessary jars to run your application to a place that will remain included with the container.


Commit and push the changes to your buildpack to your Github fork, then push your sample app to Heroku to test.  You should see:

    ...
    -----> Dropping ivy cache from the container

License
-------

Licensed under the MIT License. See LICENSE file.
