# homebrew-macserve

Homebrew tap for [macserve](https://github.com/jerryfane/macserve): use your own Mac as a private iOS build-and-test service.

```sh
brew tap jerryfane/macserve
brew install macserve
macserve setup --plan
```

`Formula/macserve.rb` is copied unchanged from each macserve release's `macserve.rb` asset (pinned version, URL and sha256 from that release's `SHA256SUMS`). Updates land as one-line PRs after each release.
