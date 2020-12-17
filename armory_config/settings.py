 #!/usr/bin/python3

import os
import pathlib

data_path = pathlib.Path(str(pathlib.Path().absolute()) + "/armory_data")
home = str(pathlib.Path.home())
custom_modules = "/tools/armory_custom/modules"
custom_reports = "/tools/armory_custom/reports"

if data_path.exists():
    data_path = str(pathlib.Path().absolute()) + "/armory_data"
else:
    os.mkdir("armory_data")
    data_path = str(pathlib.Path().absolute()) + "/armory_data"


ARMORY_CONFIG = {
    'ARMORY_BASE_PATH': data_path,

#'ARMORY_CUSTOM_MODULES': [
#    home + custom_modules,
#],

#'ARMORY_CUSTOM_REPORTS': [
#    home + custom_reports,
#],
}

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(ARMORY_CONFIG['ARMORY_BASE_PATH'], 'db.sqlite3'),
    }
}