import os
import ftplib
import sys

from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer


def run():
    user = os.environ["FTP_USER"]
    password = os.environ["FTP_PASSWORD"]
    home_dir = os.environ["FTP_HOMEDIR"]
    passive_port_range = os.environ["FTP_PASSIVE_PORT_RANGE"]
    passive_port_range_begin = int(passive_port_range.split("-")[0])
    passive_port_range_end = int(passive_port_range.split("-")[1])

    authorizer = DummyAuthorizer()

    # Permissions: https://pyftpdlib.readthedocs.io/en/latest/api.html#pyftpdlib.authorizers.DummyAuthorizer.add_user
    authorizer.add_user(user, password, home_dir, perm='elradfmwMT')
    authorizer.add_user("healthcheck", "healthcheck", home_dir, perm='elr')

    handler = FTPHandler
    handler.authorizer = authorizer

    handler.banner = "FTP server ready."

    # Passive ports, notice that range has to be +1 to get the last port
    handler.passive_ports = range(passive_port_range_begin, passive_port_range_end + 1)

    # Listen on all interfaces, port 21
    address = ('', 21)
    server = FTPServer(address, handler)

    server.max_cons = 256
    server.max_cons_per_ip = 5

    server.serve_forever()


def healthcheck(timeout=5):
    user = "healthcheck"
    password = "healthcheck"

    try:
        with ftplib.FTP() as ftp:
            ftp.connect(host="127.0.0.1", port=21, timeout=timeout)
            ftp.login(user=user, passwd=password)
            ftp.quit()
        sys.exit(0)
    except Exception as e:
        print(f"FTP health check failed: {e}")
        sys.exit(1)
