#!/usr/bin/env python
import os
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "Platformizacja.settings")

from game_app.utils.websockets.user_websocket import ws_handler
from MUD_ADMIN.game import properties


import sys
from tornado.options import options, define, parse_command_line
import django.core.handlers.wsgi
import tornado.httpserver
import tornado.ioloop
import tornado.web
from tornado.websocket import WebSocketHandler
import tornado.wsgi
import logging
from game_app.utils.ModuleManager import module_manager
from game_app.command.settings.command_definition import *
#from game_app.utils.schedulers.scheduler import *  #switch onn schedulers

#to run templates manage.py runserver

module_manager.init_all_modules()

module_manager.register_command(player)
module_manager.register_command(say)
module_manager.register_command(whisper)
module_manager.register_command(skills)
module_manager.register_command(sett)
module_manager.register_command(character_card)
module_manager.register_command(helpp)

print(module_manager.get_all_modules())

define('port', type=int, default=properties.DEFAULT_PORT)
#tornado.options.options['log_file_prefix'].set('/var/www/mud/env/tornado_server.log')
tornado.options.parse_command_line()

class MudSocketHandler(tornado.websocket.WebSocketHandler):
    def open(self):
        self.user_name = self.get_argument("username")
        ws_handler.register(self.user_name, self)

    def on_close(self):
        ws_handler.unregister(self.user_name)

    def on_message(self, message):
        logger = logging.getLogger(__name__)
        logger.setLevel(logging.DEBUG)
        logger.debug("message received")
        self.write_message("Received from client: {0}".format(message))


if __name__ == "__main__":
    logger = logging.getLogger(__name__)
    wsgi_app = tornado.wsgi.WSGIContainer(django.core.wsgi.get_wsgi_application())

    tornado_app = tornado.web.Application(
        [
            (r'/static/(.*)', tornado.web.StaticFileHandler, {'path': 'static/'}),
            ('/ws', MudSocketHandler),
            ('.*', tornado.web.FallbackHandler, dict(fallback=wsgi_app)),
        ], debug=True)

    logger.info("Tornado server starting...")
    server = tornado.httpserver.HTTPServer(tornado_app)
    server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)




