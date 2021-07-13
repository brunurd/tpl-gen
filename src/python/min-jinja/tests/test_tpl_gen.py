import os
from src.tpl_gen import main, set_vars


def test_main():
    if os.getenv("ENV_TYPE") is None:
        os.environ["ENV_TYPE"] = "tst"

    _, product_dir, env_type = set_vars()
    main()

    gen_file_p = os.path.join(product_dir, "src", "bash",
                              "demo", "tst", "demo.sh")
    gen_file_contents = ""

    with open(gen_file_p, "r") as gen_file:
        gen_file_contents = gen_file.read()

    assert gen_file_contents == f"""#!/bin/bash

echo ENV_TYPE is {env_type}
echo AWS_ACCOUNT_ID: 371922612222
sleep 3"""
