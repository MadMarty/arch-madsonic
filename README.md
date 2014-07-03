Latest stable Madsonic release from Arch Linux AUR using Packer to compile.

This is a Dockerfile for Madsonic (fork of Subsonic) - http://www.madsonic.org/

Pull image using:-

```
docker pull binhex/arch-madsonic
```

Run container using:-

```
docker run -d -p 4040:4040 --name=<container name> -v <path for data files>:/data -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro binhex/arch-madsonic
```

**Note** - Please replace all user variables in the above command defined by <> with the correct values.