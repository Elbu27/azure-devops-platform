import logging
import os
from datetime import datetime, timezone

from flask import Flask, jsonify, request


def create_app() -> Flask:
    app = Flask(__name__)
    app.config["APP_NAME"] = os.getenv("APP_NAME", "cloud-status-api")
    app.config["APP_VERSION"] = os.getenv("APP_VERSION", "1.0.0")

    logging.basicConfig(
        level=os.getenv("LOG_LEVEL", "INFO"),
        format="%(asctime)s %(levelname)s %(name)s %(message)s",
    )

    @app.after_request
    def add_request_metadata(response):
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["X-Frame-Options"] = "DENY"
        response.headers["Cache-Control"] = "no-store"
        app.logger.info(
            "request method=%s path=%s status=%s",
            request.method,
            request.path,
            response.status_code,
        )
        return response

    @app.get("/")
    def index():
        return jsonify(
            service=app.config["APP_NAME"],
            version=app.config["APP_VERSION"],
            message="Azure DevOps portfolio API",
        )

    @app.get("/healthz")
    def health():
        return jsonify(
            status="healthy", timestamp=datetime.now(timezone.utc).isoformat()
        )

    @app.get("/readyz")
    def readiness():
        return jsonify(status="ready")

    return app


app = create_app()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "8080")))
