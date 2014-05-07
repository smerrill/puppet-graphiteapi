#### puppet-graphiteapi

_(Also includes carbon.)_

### Beginning with graphiteapi

Install the other modules that are needed.

```
include graphiteapi
```

This will set up Carbon using the packages from EPEL and will set up graphite-api running on localhost:8080.

##Limitations

This module only runs on RHEL 6 to my knowledge.

This module does not provide for any configuration of Carbon yet.
