# -*- coding: utf-8 -*-

import pytest

# known run environment values to be used as part of the cmdline arg --run_env
KNOWN_RUN_ENV = ['local']

# add parser for cmdline arguments
def pytest_addoption(parser):
    parser.addoption(
        "--run_env",
        action="store",
        help=(
            "the run environment of the app where the tests"
            " are executed against (i.e. local, dev, stage, prod)"
        ),
    )

# establish the base cfg for all tests
@pytest.fixture(autouse=True)
def cfg(request):
    DEFAULT_ERR_BODY = {
        "code": 405,
        "description": "The method is not allowed for the requested URL.",
        "name": "Method Not Allowed"
    }
    base_url = "NEEDED, see conftest.py for more details"
    run_env = str(request.config.getoption("--run_env")).lower()

    if run_env not in KNOWN_RUN_ENV:
        raise ValueError(
            "unknown run_env: '{0}', "
            "known --run_env values: '{1}'".format(run_env, KNOWN_RUN_ENV))
    elif run_env.lower() == 'local':
        base_url = "http://localhost:9876"

    opts = {
        "run_env": run_env,
        "base_url": base_url,
        "default_err_body": DEFAULT_ERR_BODY
    }

    print("run configuration options used:\n {0}".format(opts))

    return opts
