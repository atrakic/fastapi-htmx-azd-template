def test_index(app_client):
    response = app_client.get("/")
    assert response.status_code == 200


def test_post_data(app_client):
    response = app_client.post("/add", data={"content": "First task"})
    assert response.status_code == 200


def test_post_data_error(app_client):
    response = app_client.post("/add", data={"foo": "Error task"})
    assert response.status_code == 422
