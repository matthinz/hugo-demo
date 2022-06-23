# Hugo demo

This is a demo [Hugo](https://gohugo.io) website built using the US Web Design System.

## Notes / errata / things to do

- **Hugo uses libsass by default**

  USWDS 3 uses features provided by `dart-sass`. Hugo supports building using [`dart-sass-embedded`](https://github.com/sass/dart-sass-embedded) as long as the binary is on `$PATH`.

- **Assets referenced by CSS not fingerprinted**

  Something like [`postcss-url`](https://github.com/postcss/postcss-url) might do the job.

- **`.TableOfContents` not customizable**

  Hugo renders the actual TOC HTML, but does not provide the underlying data.
