# Diego Lavalle Dot Com (Data)

Sources for data.diegolavalle.com.

## Developing

To serve local version during development use Python.

```sh
python3 -m http.server --directory www
```

## Generating the site

Make sure you export an environment variable named `GITHUB_API_TOKEN` containing your GitHub token. This can also be done via scheme settings on Xcode or on Netlify's configuration.

## Set up publishing

In Netlify add the `data` branch to _Site settings, Build & deploy, Branches, Branch deploys_.

First time only, add the publish remote.

```sh
git remote add publish github.com:diegolavalledev/diegolavalle.com
```

Create the branch on the repository monitored by Netlify.

```sh
git push publish develop:data
```

Again in Netlify create the subdomain based on the deployment branch by selecting it in _Site settings, Domain management, Branch subdomains, Create branch subdomain_. This action will trigger an immediate build so there is no need to push the branch again. 

## Publishing

For publishing from developing branch push to the publish remote using the correct destination branch name.

```sh
git push publish develop:data
```
