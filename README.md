Latest stable madsonic release from Arch Linux AUR via Packer.

Pull down image using:-
docker pull binhex/arch-madsonic

Create container using:-
docker run -d -p 4040:4040 -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro --name=<container name> binhex/arch-madsonic