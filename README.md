# tpl-gen (A Minimalistic Jinja templates generator)

[![GitHub](https://img.shields.io/github/license/brunurd/tpl-gen)][license-url]

A template generator using Jinja2 and Smarty TPL files.

---

## Prerequisites
- bash
- make
- docker

---

## Usage
Is possible to show all available make actions calling:
```bash
make help
# or
make
```

## SETUP
Build an ubuntu 20.04 image and initialize a container with all required dependencies:
```bash
make install
# you should wait a bit after the attach to give the 

# which is the same as 
make install-tpl-gen
# to run without using the docker cache
make clean-install-tpl-gen
```

## LINT
Build an ubuntu 20.04 image and initialize a container with all required dependencies:
```bash
# run the tests in the tpl-gen python project
docker exec -it tpl-gen-tpl-gen-con ./run -a do_run_pylint_in_python_files
```

## TESTS
Build an ubuntu 20.04 image and initialize a container with all required dependencies:
```bash
# run the tests in the tpl-gen python project
make do-test-tpl-gen
```



## Run
Run the Templating 
```bash
make do-tpl-gen
```

[license-url]: LICENSE
