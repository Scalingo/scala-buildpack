Buildpack: Scala
================

This is a [Buildpack](http://doc.scalingo.com/buildpacks) for Scala apps.
It uses [sbt](https://github.com/sbt/sbt) 0.11.0+.

How it works
-----

The buildpack will detect your app as Scala if it has a `project/build.properties` file and either a `.sbt` or `.scala` based build config (for example, a `build.sbt` file).  It vendors a version of sbt into your slug (if you are not using sbt-native-packager, it also includes your popluated `.ivy/cache` in the slug).  The `.ivy2` directory will be cached between builds to allow for faster build times.

It is strongly recommended that you use sbt-native-packager with this buildpack instead of sbt-start-script. The latter is deprecated, and will result in exessively large slug sizes. 

    $ scalingo create scala-app

    $ git push scalingo master
    ...
    -----> Scala app detected
    -----> Building app with sbt
    -----> Running: sbt compile stage

The buildpack will detect your app as Scala if it has the project/build.properties and either .sbt or .scala based build config.  It vendors a version of sbt and your popluated .ivy/cache into your container.  The .ivy2 directory will be cached between builds to allow for faster build times.

Documentation
------------

For more information about using Scala and buildpacks on Scalingo, see these articles:

*  [Scalingo's Scala Support](http://doc.scalingo.com/languages/scala)

Customizing
-----------

This buildpack uses [sbt-extras](https://github.com/paulp/sbt-extras) to run sbt.
In this way, the execution of sbt can be customized either by setting
the SBT_OPTS config variable, or by creating a `.sbtopts` file in the
root directory of your project. When passing options to the underlying
sbt JVM, you must prefix them with `-J`. Thus, setting stack size for
the compile process would look like this:

```
$ scalingo env-set SBT_OPTS="-J-Xss4m"
```

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

Development
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
