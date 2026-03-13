import flask
import mysql.connector
from mysql.connector import Error
import webbrowser

app = flask.Flask(__name__)
app.secret_key = "tabletopshopsecretkey"

DB_HOST = "localhost"
DB_USER = "root"
DB_PASSWORD = "Bobo_102402"
DB_NAME = "tabletopshop"


def get_server_connection():
    return mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD
    )


def get_db_connection():
    return mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME
    )


def init_database():
    conn = None
    cursor = None

    try:
        conn = get_server_connection()
        cursor = conn.cursor()
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS {DB_NAME}")
        conn.commit()
        print(f"Database {DB_NAME} is ready.")

    except Error as e:
        print(f"Error occurred: {e}")

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()


@app.route("/")
def index():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("""
        SELECT product_id, product_name, stock, price
        FROM product
        ORDER BY product_id
    """)

    products = cursor.fetchall()

    cursor.close()
    conn.close()
    return flask.render_template("index.html", products=products)


if __name__ == "__main__":
    init_database()
    webbrowser.open("http://127.0.0.1:5000")
    app.run(debug=True, use_reloader=False)