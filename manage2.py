#file for creating database
#run: manage2.py syncdb

#!/usr/bin/env python
import os
import sys
from game_app.utils.ModuleManager import ModuleManager


if __name__ == "__main__":

    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "Platformizacja.settings")
	print("123")
    module_manager = ModuleManager()
    module_manager.init_all_modules()
    print(module_manager.get_all_modules())

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)

    # uncomment it to create superuser if does not exist yet
    #
    from django.db import DEFAULT_DB_ALIAS as database
    from django.contrib.auth.models import User
    User.objects.db_manager(database).create_superuser('root', 'piotr.proc@gmail.com', 'root')
