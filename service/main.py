import logging

from fastapi import FastAPI
from starlette.responses import Response

from . import __version__, api, solver


log = logging.getLogger(__name__)   # pylint: disable=invalid-name


app = FastAPI(  # pylint: disable=invalid-name
    title='DevOps Assignment',
    description='Find minimal number of devops to maintain given servers.',
    version=__version__,
)
app.include_router(api.router)


@app.on_event('startup')
def startup():
    solver.init()


@app.on_event('shutdown')
def shutdown():
    solver.shutdown()


@app.get('/', include_in_schema=False)
def index():
    return Response("I'm up", media_type='text/plain')
