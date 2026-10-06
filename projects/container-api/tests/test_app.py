from app import create_app


def client():
    application = create_app()
    application.config.update(TESTING=True)
    return application.test_client()


def test_index_returns_service_metadata():
    response = client().get("/")
    assert response.status_code == 200
    assert response.json["service"] == "cloud-status-api"
    assert response.json["version"]


def test_health_endpoint():
    response = client().get("/healthz")
    assert response.status_code == 200
    assert response.json["status"] == "healthy"
    assert response.json["timestamp"].endswith("+00:00")


def test_readiness_endpoint():
    response = client().get("/readyz")
    assert response.status_code == 200
    assert response.json == {"status": "ready"}


def test_security_headers_are_set():
    response = client().get("/")
    assert response.headers["X-Content-Type-Options"] == "nosniff"
    assert response.headers["X-Frame-Options"] == "DENY"
    assert response.headers["Cache-Control"] == "no-store"
