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
