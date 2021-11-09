# Diego Lavalle Dot Com (Data)

Sources for data.diegolavalle.com.

## Developing

To serve local version during development use Python.

```sh
python3 -m http.server --directory www
```

## Set up publishing

In Netlify add the `data` branch to _Site Settings, Build & Deploy, Branches, Branch deploys_.

First time only, add the publish remote.

```sh
git remote add publish github.com:diegolavalledev/diegolavalle.com
```

## Publishing

For publishing from developing branch push to the publish remote using the correct destination branch name.

```sh
git push publish develop:data
```
