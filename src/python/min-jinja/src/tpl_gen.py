#!/usr/bin/env python3

import time
import os
from os import path
import json
import glob
from jinja2 import Environment, BaseLoader, exceptions
from pprintjson import pprintjson
from colorama import Fore, Style


def main():
    cnf, product_dir, env_type = set_vars()
    do_generate(cnf, product_dir, env_type)


def print_warn(msg):
    print(f"{Fore.YELLOW}{msg}{Style.RESET_ALL}")


def print_error(msg):
    print(f"{Fore.RED}{msg}{Style.RESET_ALL}")


def print_success(msg):
    print(f"{Fore.GREEN}{msg}{Style.RESET_ALL}")


def set_vars():
    try:
        product_dir = path.join(__file__, "..", "..", "..", "..", "..")
        product_dir = path.abspath(product_dir)
        env_type = os.getenv("ENV_TYPE")
        json_cnf_file = f"{product_dir}/cnf/env/{env_type}.env.json"

        print(f"tpl_gen.py ::: using config json file: {json_cnf_file}")
        time.sleep(1)

        with open(json_cnf_file) as json_cnf_file:
            cnf = json.load(json_cnf_file)

        pprintjson(cnf)

    except IndexError as error:
        raise Exception("ERROR in set_vars: ", str(error)) from error

    return cnf, product_dir, env_type


def do_generate(cnf, product_dir, env_type):
    pathnames = [
        f"{product_dir}/src/tpl/**/*.tpl",
        f"{product_dir}/src/tpl/**/.*.tpl",
    ]
    for pathname in pathnames:
        for current_file_path in glob.iglob(pathname, recursive=True):
            try:
                with open(current_file_path, "r") as current_file:
                    str_tpl = current_file.read()
                    obj_tpl = Environment(loader=BaseLoader) \
                        .from_string(str_tpl)
                    args = os.environ.copy()
                    args.update(cnf["env"])
                    rendered = obj_tpl.render(args)
                    tgt_file_path = current_file_path.replace("/src/tpl", "", 1) \
                        .replace(".tpl", "") \
                        .replace(r"%env%", env_type)

                    if not path.exists(path.dirname(tgt_file_path)):
                        os.makedirs(path.dirname(tgt_file_path))

                    with open(tgt_file_path, "w") as tgt_file:
                        tgt_file.write(rendered)
                        msg = f"File \"{tgt_file_path}\" rendered with success."
                        print_success(msg)

            except exceptions.UndefinedError as error:
                msg = "WARNING: Missing variable in json config in file: " + \
                    f"\"{current_file_path}\" - {error}"
                print_warn(msg)

            except Exception as error:
                print_error(f"RENDERING EXCEPTION: \n{error}")
                raise error

    print("STOP generating templates")


if __name__ == "__main__":
    main()
