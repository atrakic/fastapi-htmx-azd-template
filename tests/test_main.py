
def test_index(app_client):
    response = app_client.get("/")
    assert response.status_code == 200
    assert response.headers["content-type"] == "text/html; charset=utf-8"


def test_post_data(app_client):
    response = app_client.post("/add", data={"content": "First task"})
    assert response.status_code == 200
    assert response.headers["content-type"] == "text/html; charset=utf-8"


def test_post_data_error(app_client):
    response = app_client.post("/add", data={"foo": "Error task"})
    assert response.status_code == 422


def test_healthcheck(app_client):
    response = app_client.get("/healthcheck")
    assert response.status_code == 200
    assert response.json() == {"message": "Healthy"}


def test_get_edit(app_client):
    response = app_client.get("/edit/1")
    assert response.status_code == 200
    assert response.headers["content-type"] == "text/html; charset=utf-8"


# def test_put_edit(app_client):
#    response = app_client.put("/edit/1", data={"content": "Updated task"})
#    assert response.status_code == 200
#    assert response.headers["content-type"] == "text/html; charset=utf-8"

# def test_delete(app_client):
#     response = app_client.delete("/delete/1")
#     assert response.status_code == 200
