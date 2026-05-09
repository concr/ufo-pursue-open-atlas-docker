#!/usr/bin/env python3

import os
import sys
import urllib.request

url = os.environ.get("HEALTHCHECK_URL", "http://127.0.0.1:8000/")

try:
    response = urllib.request.urlopen(url, timeout=3)
    sys.exit(0 if 200 <= response.status < 400 else 1)
except Exception as error:
    print(error)
    sys.exit(1)
