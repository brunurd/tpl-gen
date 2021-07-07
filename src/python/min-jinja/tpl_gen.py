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

product_dir, tgt_proj_dir, json_cnf_fle, cnf, pp, = '', '', '', '', ''


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
        global product_dir, json_cnf_fle, cnf, pp, cnf, tgt_proj_dir
        pp = pprint.PrettyPrinter(indent=3)
        product_dir = path.abspath(path.join(__file__, "..", "..", "..", ".."))
        product_name = re.sub(r'(.*)[//](.*)(.*?)$', r'\2',product_dir)
        env = os.getenv('ENV_TYPE')
        tgt_proj = product_name
        tgt_proj_dir = product_dir
        json_cnf_fle = product_dir + '/cnf/env/' + env + '.env.json'

        print("tpl_gen.py ::: using config json file: ", str(json_cnf_fle))
        print(time.sleep(1))

        with open(json_cnf_fle) as json_cnf_fle:
            cnf = json.load(json_cnf_fle)
        ppjson(cnf)

    except(IndexError) as error:
        print("ERROR in set_vars: ", str(error))
        traceback.print_stack()
        sys.exit(1)


def do_read_conf_fle(f):
    try:
        with open(f, 'r') as fh:
            vars_dict = dict(
                tuple(line.rstrip().split('='))
                for line in fh.readlines() if not line.startswith('#') and not line.startswith('\n')
            )
        os.environ.update(vars_dict)
    except (Exception) as error:
        print_error(f'ERROR in do_read_conf_fle:{error}')
        traceback.print_stack()
    finally:
        print("RUNNING in the following env: ", vars_dict)


def do_generate(cnf):
    pathnames = [
        f'{product_dir}/src/tpl/**/*.tpl',
        f'{product_dir}/src/tpl/**/.*.tpl',
    ]
    for pathname in pathnames:
        for f in glob.iglob(pathname, recursive=True):
            try:
                # print ( "read template file: " , f)
                # pp.pprint (cnf)
                str_tpl = open(f, 'r').read()
                obj_tpl = Environment(loader=BaseLoader).from_string(str_tpl)
                vars = os.environ.copy()
                vars.update(cnf['env'])
                rendered = obj_tpl.render(vars)
                # print(cnf)
                # pp.pprint ( rendered )
                tgt_fle = f.replace('/src/tpl', '', 1).replace('.tpl', '').replace(r'%env%', cnf['env']['ENV_TYPE'])
                if not os.path.exists(os.path.dirname(tgt_fle)):
                    os.makedirs(os.path.dirname(tgt_fle))
                # print (rendered)
                print(rendered,  file=open(tgt_fle, 'w'))
                # print ( "output ready rendered file : " , tgt_fle)
                print_success(f'File "{tgt_fle}" rendered with success.')
            except exceptions.UndefinedError as undef_err:
                print_warn(
                    f'WARNING: Missing variable in json config in file: "{f}" - {undef_err}')
            except Exception as e:
                print_error(f'RENDERING EXCEPTION: \n{e}')
                traceback.print_stack()
    print("STOP generating templates")


main()
