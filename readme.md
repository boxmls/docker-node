Docker Image extended with BoxMLS infrastructure requirements.

- Node v8 ([8-jessie](https://hub.docker.com/r/library/node/tags/8-jessie/)) 
- Crete a standard `core` user.
- Install Node.js v8 with common runtime modules.
- Create common directory structure for all service containers.

The NPM version was hardcoded - 8.1.0. Latest version does not work with Node JS 8.

To build locally, run:

```
docker build .  --tag=boxmls/node:v8-dev
```

