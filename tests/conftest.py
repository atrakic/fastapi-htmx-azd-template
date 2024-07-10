import sqlite3
import pytest
from fastapi.testclient import TestClient
from starlette.templating import Jinja2Templates

from main import app

templates = Jinja2Templates(directory="templates")


@pytest.fixture
def session():
    connection = sqlite3.connect(":memory:")
    db_session = connection.cursor()
    yield db_session
    connection.close()


@pytest.fixture()
def app_client():
    with TestClient(app) as client:
        yield client
