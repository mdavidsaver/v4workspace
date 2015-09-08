pva 2 pva gateway/proxy


To build


```shell
git clone --recursive -b pva2pva https://github.com/mdavidsaver/v4workspace
cd v4workspace
make -C epics-base
make -c pvData
make -c pvAccess
make -c pvaSrv
make -C pva2pva
```

To run the demo open three shells in parallel.

One

```shell
./pvaSrv/bin/linux-x86/softIocPVA count.cmd
```

Two

```shell
./pva2pva/bin/linux-x86/p2p rungw.cmd
```

Three

```shell
./pvAccess/bin/linux-x86_64/pvget -m xcnt
```

In this demo the client 'pvget' connects to 'xcnt'
which is served by the p2p proxy to the real channel
'ycnt' provided by the softIoc.


Depending on local firewall rules, it may be necessary to
set the 'EPICS_PVA_ADDR_LIST' environment variable in
all three shells.

```shell
EPICS_PVA_ADDR_LIST=localhost
```
