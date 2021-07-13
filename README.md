# min-jinja (Minimalistic Jinja)

[![GitHub](https://img.shields.io/github/license/brunurd/min-jinja)][license-url]

A template generator using Jinja2 and Smarty TPL files.

---

## **Prerequisites**
- Python (version 3.8 or superior)
- Make
- Docker (optional)

---

## **Usage**
Is possible to show all available `make` actions calling:
```bash
make help
# or
make
```
---
### **With Docker**


#### ___1. Install___
Build an ubuntu 20.04 image and initialize a devops container with all required dependencies:
```bash
make install
```


#### ___2. Run___
Run the main template generation function, choose an environment to extract the variables (the environment files are on the `cnf/env` folder):
```bash
ENV_TYPE=<env> make do_run
```
---
### **Locally**


##### ___1. Install___
Call the script below to install python dependencies locally using poetry, this script install poetry if you don't have it yet:
```bash
./run -a do_check_install_python_modules
```


##### ___2. Run___
Run the main template generation function, choose an environment to extract the variables (the environment files are on the `cnf/env` folder):
```bash
ENV_TYPE=<env> make run
```
---
### **Generate one project from this one**
This project has a command to generate a new project from this one (like a template), the project will be generated on the same parent folder, just call:
```bash
TGT_PROJ=<project-name> make spawn_tgt_project
```

[license-url]: LICENSE
