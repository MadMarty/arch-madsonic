Madsonic
=========

Madsonic - http://www.madsonic.org/

Latest Public Release of Madsonic.

**Pull image**

```
docker pull binhex/arch-madsonic
```

**Run container**

```
docker run -d -p 4040:4040 -p 4050:4050 --name=<container name> -v <path for media files>:/media -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro binhex/arch-madsonic
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

```
http://<host ip>:4040
```

or for SSL

```
https://<host ip>:4050
```



