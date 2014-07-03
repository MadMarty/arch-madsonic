Latest stable Madsonic release from Arch Linux AUR using Packer to compile.

This is a Dockerfile for Madsonic (fork of Subsonic) - http://www.madsonic.org/

**Pull image**

```
docker pull binhex/arch-madsonic
```

**Run container**

```
docker run -d -p 4040:4040 -p 4050:4050 --name=<container name> -v <path for data files>:/data -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro binhex/arch-madsonic
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

```
http://<host ip>:4040
```

or for ssl

```
https://<host ip>:4050
```



