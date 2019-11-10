Why
===

I try to reproduce https://learn.hashicorp.com/consul/getting-started/connect
but some step is missing in the article. So I create this Vagrant box to
helping me in consul connect experimentation.

Launch
======

```
vagrant up
vagrant ssh
/vagrant/launch_tmux.sh
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
nc 127.0.0.1 9191
consul intention create -deny '*' '*'
consul intention create -allow web socat
```
