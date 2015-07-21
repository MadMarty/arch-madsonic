Madsonic
=========

Madsonic - http://www.madsonic.org/

Latest Public Release of Madsonic.

**Pull image**

```
docker pull madevil/arch-madsonic
```

**Run container**

```
docker run -d -p 4040:4040 -p 4050:4050 --name=<container name> -e SSL="yes" -v <path for media files>:/media -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro madevil/arch-madsonic
```

Please replace all user variables in the above command defined by <> with the correct values.

Note:- If you wish to use a secure connection (HTTPS) then please set the environment variable (SSL="yes") to "yes", otherwise set to "no" to use HTTP only.

**Access application**

```
http://<host ip>:4040
```

or if you have enabled SSL

```
https://<host ip>:4050
```