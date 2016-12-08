import bcrypt
from eve import Eve
from eve.auth import BasicAuth
from flask import current_app as app

app = Eve()

if __name__ == '__main__':
    app.run(host='0.0.0.0')
