#!/usr/bin/env python3
# purpose: a quick and dirty semi-generic template generator, based on dir naming convention and
# shallow data structure ...
# usage: poetry run src/python/min-jinja/tpl_gen.py

import time
import sys
import os
import re
import os.path as path
import json
import glob
import pprint
import traceback
from jinja2 import Environment, BaseLoader, exceptions
from pprintjson import pprintjson as ppjson
from colorama import Fore, Style

product_dir, tgt_proj_dir, json_cnf_fle, cnf, pp, env_type = '', '', '', '', '', ''


def main():
    set_vars()
    do_generate(cnf)
    sys.exit(0)


def print_warn(msg):
    print(f'{Fore.YELLOW}{msg}{Style.RESET_ALL}')


def print_error(msg):
    print(f'{Fore.RED}{msg}{Style.RESET_ALL}')


def print_success(msg):
    print(f'{Fore.GREEN}{msg}{Style.RESET_ALL}')


def set_vars():
    try:
        global product_dir, json_cnf_fle, cnf, pp, cnf, tgt_proj_dir, env_type
        pp = pprint.PrettyPrinter(indent=3)
        product_dir = path.abspath(path.join(__file__, "..", "..", "..", ".."))
        product_name = re.sub(r'(.*)[//](.*)(.*?)$', r'\2',product_dir)
        env_type = os.getenv('ENV_TYPE')
        tgt_proj = product_name
        tgt_proj_dir = product_dir
        json_cnf_fle = product_dir + '/cnf/env/' + env_type + '.env.json'

        print("tpl_gen.py ::: using config json file: ", str(json_cnf_fle))
        print(time.sleep(1))

        with open(json_cnf_fle) as json_cnf_fle:
            cnf = json.load(json_cnf_fle)
        ppjson(cnf)

    except(IndexError) as error:
        print("ERROR in set_vars: ", str(error))
        traceback.print_stack()
        sys.exit(1)


def do_generate(cnf):
    pathnames = [
        f'{product_dir}/src/tpl/**/*.tpl',
        f'{product_dir}/src/tpl/**/.*.tpl',
    ]
    for pathname in pathnames:
        for f in glob.iglob(pathname, recursive=True):
            try:
                str_tpl = open(f, 'r').read()
                obj_tpl = Environment(loader=BaseLoader).from_string(str_tpl)
                vars = os.environ.copy()
                vars.update(cnf['env'])
                rendered = obj_tpl.render(vars)
                tgt_fle = f.replace('/src/tpl', '', 1).replace('.tpl', '').replace(r'%env%', env_type)
                if not os.path.exists(os.path.dirname(tgt_fle)):
                    os.makedirs(os.path.dirname(tgt_fle))
                print(rendered,  file=open(tgt_fle, 'w'))
                print_success(f'File "{tgt_fle}" rendered with success.')
            except exceptions.UndefinedError as undef_err:
                print_warn(
                    f'WARNING: Missing variable in json config in file: "{f}" - {undef_err}')
            except Exception as e:
                print_error(f'RENDERING EXCEPTION: \n{e}')
                traceback.print_stack()
    print("STOP generating templates")


main()
