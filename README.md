Hatohol Web Site
=================
This repository includes source code of [Hatohol web site](http://www.hatohol.org)

Dependency
-----------
You have to compile files to generate HTML files.
gen.py compile files automatically.

It requires following libraries:

- Python 3
- python-markdown
- unoconv
- Sass

```shell
    sudo apt-get install python3 python3-markdown unoconv ruby-dev
    sudo gem install sass
```

How to compile
---------------
gen.py automatically generates output files including HTML, CSS, images, and so on.  
BE CAREFUL AS ALL THE FILES IN THE DIRECTORY WILL BE DELETED.

    ./gen.py --output /path/to/output/directory

Stop all LibreOffice instance to avoid conversion error by unoconv.

How to deploy
--------------
Currently we use sourceforge.jp's hosting server. See [sourceforge.jp's official documents](http://sourceforge.jp/docs/FrontPage#h2-Web.E3.82.B5.E3.82.A4.E3.83.88.E3.81.AE.E3.83.9B.E3.82.B9.E3.83.86.E3.82.A3.E3.83.B3.E3.82.B0.E3.81.AB.E9.96.A2.E3.81.99.E3.82.8B.E6.96.87.E6.9B.B8) for details.

1. Add your SSH key on [sourceforge.jp's config page](https://sourceforge.jp/account/editsshkeys.php).

2. Login to sftp://shell.sourceforge.jp and open /home/groups/h/ha/hatohol/htdocs

3. Put the generated HTMLs there.

Source code
---------------

### Directory structure
    ├── contents
    │   ├── assets
    │   │   ├── images
    │   │   │   ├── diagrams     - diagram images (mainly ODG format)
    │   │   │   │   └── …
    │   │   │   ├── hatohol.png  - logo
    │   │   │   └── screenshots
    │   │   │       └── …
    │   │   ├── javascripts
    │   │   │   └── …
    │   │   └── stylesheets
    │   │       ├── bootstrap    - SCSS files of Bootstrap
    │   │       │   └…
    │   │       └── styles.scss  - Style files
    │   ├── docs
    │   │   ├── index.md         - /docs/
    │   │   ├── install          - Document files. URL structure is: /docs/[hatohol version]/[language]/
    │   │   │   ├── 13.12
    │   │   │   │   ├── en
    │   │   │   │   │   └── index.md
    │   │   │   │   └── ja
    │   │   │   │       └── index.md
    │   │   │   └── …
    │   │   └── markdown-checker - Legacy scripts for markdown conversion; Maybe not required?
    │   ├── 404.md               - 404 page
    │   ├── about.tpl            - /about/
    │   ├── commercial.tpl       - /commercial/
    │   ├── contrib.tpl          - /contrib/
    │   ├── download.tpl         - /download/
    │   ├── index.tpl            - /
    │   ├── screenshots.tpl      - /screenshots/
    │   └── updates.tpl          - /updates/
    ├── gen.py                   - HTML generation script
    ├── layouts                  - template files: common header and footer for each HTML files
    └── README.md

Each [filename].tpl and [filename].md files are converted to [filename]/index.html

In this repository, there are some kinds of files to be compiled.
- .tpl: HTML template files. .tpl files under content directory only have body content. They are merged with layout/header.tpl and layout/footer.tpl. Content of first h1 tag is assigned to page title.
- .md: Markdown files. They are compiled by [python-markdown](https://pypi.python.org/pypi/Markdown), then merged with layout/header.tpl and layout/footer.tpl.
- .scss: Sass files. They are compiled to CSS files by sass command.
- .odg: OpenDocument Graphics files. They are converted to PNG by unoconv.

