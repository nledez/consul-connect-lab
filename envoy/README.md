Why
===

I try to reproduce https://learn.hashicorp.com/consul/developer-mesh/connect-envoy
but some step is missing in the article. So I create this Vagrant box to
helping me in consul connect experimentation.

Launch
======

```
vagrant up consul01
vagrant ssh consul01

vagrant up
/vagrant/launch_tmux.sh
vagrant ssh consul02
/vagrant/launch_tmux.sh
vagrant ssh consul03
/vagrant/launch_tmux.sh

vagrant ssh consul01
/vagrant/launch_tmux.sh app
```

kill all when done
==================

```
/vagrant/launch_tmux.sh kill
exit
vagrant destroy
```

Test it
=======

```
docker run -ti --rm --network host gophernet/netcat localhost 9191
docker run -ti --rm --network host consul:latest intention create -deny '*' '*'
docker run -ti --rm --network host consul:latest intention create -allow client echo

# docker run -ti --rm --network host consul:latest intention delete client echo
# consul intention create -deny '*' '*'
# consul intention create -allow web socat
```
