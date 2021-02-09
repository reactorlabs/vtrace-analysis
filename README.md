vtrace-analysis
===============

Work in progress.

A study of how vectors and data frames are used in R.

This repo contains the scripts for running the tracer and analyzing the output.
The tracing is done by the [`vtrace`](https://github.com/reactorlabs/vtrace)
package.

Getting Started
---------------

```
# Create parent directory
mkdir vtrace-dev && cd vtrace-dev

# Download and build dependencies
git clone --branch r-4.0.2 git@github.com:PRL-PRG/R-dyntrace.git && \
    cd R-dyntrace && ./build && cd ..
git clone git@github.com:PRL-PRG/injectr.git && \
    cd injectr && ../R-dyntrace/bin/R CMD INSTALL . && cd ..
git clone git@github.com:PRL-PRG/instrumentr.git && \
    cd instrumentr && ../R-dyntrace/bin/R CMD INSTALL . && cd ..
git clone git@github.com:reactorlabs/vtrace.git && \
    cd vtrace && ../R-dyntrace/bin/R CMD INSTALL . && cd ..

# Install R utility packages
R-dyntrace/bin/R -e 'install.packages(c("devtools","dplyr"), repos="https://cloud.r-project.org")'

# Clone this repo
git clone git@github.com:reactorlabs/vtrace-analysis.git
```

Dependencies
------------

  * [R-dyntrace](https://github.com/PRL-PRG/R-dyntrace/tree/r-4.0.2) (`r-4.0.2`
    branch) - modified version of the R interpreter that exposes hooks for
    tracing
  * [injectr](https://github.com/PRL-PRG/injectr) - R package for injecting code
    into existing functions
  * [instrumentr](https://github.com/PRL-PRG/instrumentr) - R package for
    instrumenting R code; depends on R-dyntrace and injectr
  * [vtrace](https://github.com/reactorlabs/vtrace) - R package for tracing
    vector code; depends on R-dyntrace and instrumentr

Dependencies must be installed in the order listed.

### Dependency management

Currently, dependency management is manual: `cd` into the appropriate
directory, do a `git pull`, and rebuild. Dependencies are located in sibling
directories, not child directories, of this repo.

The number of dependencies is small, pulls are expected to be infrequent, and
pushes are expected to be very rare. Hopefully this manual approach will be
easier than git submodules or git subtrees -- but this decision may be
revisited.

