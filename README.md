# Diego Lavalle Dot Com

Sources for diegolavalle.com.

## Developing

Clone and add the shared and user-specific git configuration:

    git clone github.com:diegolavalle/website
    gpg --output .gitconfig/user --decrypt .gitconfig/users/[USER].gpg
    git config include.path ../.gitconfig/shared

To serve local version during development use Python.

```sh
python3 -m http.server --directory www
```

In Xcode change scheme's run working directory to the folder where the cloned repository is (i.e. `$HOME/Developer/website/`).

Run the project.

## Publishing

To commit your changes and publish:

    git push
    git push backup
    git push publish develop:www
