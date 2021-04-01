 #!/usr/bin/python3

import os
import pathlib

data_path = pathlib.Path(str(pathlib.Path().absolute()) + "/armory_data")
home = str(pathlib.Path.home())
abolute_home = "CHANGEME"
custom_modules = abolute_home + "/tools/armory_custom/modules"
custom_reports = abolute_home + "/tools/armory_custom/reports"
custom_webapps = abolute_home + "/tools/armory_webapps"

if data_path.exists():
    data_path = str(pathlib.Path().absolute()) + "/armory_data"
else:
    os.mkdir("armory_data")
    data_path = str(pathlib.Path().absolute()) + "/armory_data"


ARMORY_CONFIG = {
    'ARMORY_BASE_PATH': data_path,

    'ARMORY_CUSTOM_MODULES': [
        custom_modules,
    ],

    'ARMORY_CUSTOM_REPORTS': [
        custom_reports,
    ],
    
    'ARMORY_CUSTOM_WEBAPPS': [
         custom_webapps,
    ],
}

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(ARMORY_CONFIG['ARMORY_BASE_PATH'], 'db.sqlite3'),
    }
}