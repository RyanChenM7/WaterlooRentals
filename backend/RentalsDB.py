
import csv
from flaskext.mysql import MySQL
from backend.bcrypthash import hash, auth

mysql = MySQL()

PATH = "backend/data/"

user_schema = {
    "id": "INT NOT NULL,",
    "username": "VARCHAR(500) NOT NULL,",
    "password": "VARCHAR(500) NOT NULL,",  # Hashed password
    # "salt": "VARCHAR(500) NOT NULL,",  # Password hash salt
    # "iterations": "INT NOT NULL,",  # Password hash iterations
    "fname": "VARCHAR(100),",
    "lname": "VARCHAR(100),",
    "phone": "VARCHAR(20),",
    "email": "VARCHAR(500) NOT NULL,",
}

listing_schema = {
    "id": "INT NOT NULL, ",
    "user_id": "INT NOT NULL, ",
    "address": "VARCHAR(1000) NOT NULL, ",
    "city": "VARCHAR(300), ",
    "province": "VARCHAR(300), ",
    "rooms": "INT, ",
    "bathrooms": "INT, ",
    "feet": "INT, ",
    "heating": "INT, ",
    "water": "INT, ",
    "hydro": "INT, ",
    "type": "VARCHAR(300), ",
    "parking": "INT, ",
    "price": "INT, ",
    "months": "INT, ",
    "comment": "VARCHAR(2000), ",
}

listing_types = {
    "id": int,
    "user_id": int,
    "address": str,
    "city": str,
    "province": str,
    "rooms": int,
    "bathrooms": int,
    "feet": int,
    "heating": int,
    "water": int,
    "hydro": int,
    "type": str,
    "parking": int,
    "price": int,
    "months": int,
    "comment": str,
}


@staticmethod
def format_user(user):
    for key in user_schema.keys():
        if key not in user:
            user[key] = "N/A"
    return user


class RentalsDB:
    def __init__(self, app, user_schema=user_schema, listing_schema=listing_schema):
        self.app = app
        app.config['MYSQL_DATABASE_USER'] = 'root'
        app.config['MYSQL_DATABASE_PASSWORD'] = 'password123'
        app.config['MYSQL_DATABASE_DB'] = 'testDB'
        app.config['MYSQL_DATABASE_HOST'] = 'localhost'
        mysql.init_app(app)

        self.conn = mysql.connect()
        self.cursor = self.conn.cursor()

        self.user_schema = user_schema
        self.listing_schema = listing_schema

    def get_connection(self):
        return self.conn, self.cursor


    """
    Creates new USERS and LISTINGS databases.
    """
    def initialize_database(self):
        self.cursor.execute("DROP TABLE IF EXISTS listings")
        self.cursor.execute("DROP TABLE IF EXISTS users")

        temp = "".join(key + " " + val + " " for key, val in self.user_schema.items())
        CREATE_USERS = "CREATE TABLE IF NOT EXISTS users (" + temp + "PRIMARY KEY (id))"

        temp = "".join(key + " " + val for key, val in self.listing_schema.items())
        CREATE_LISTING = "CREATE TABLE IF NOT EXISTS listings (" + temp \
            + "PRIMARY KEY (id), FOREIGN KEY (user_id) REFERENCES users(id))"

        self.cursor.execute(CREATE_USERS)
        self.cursor.execute(CREATE_LISTING)

        self.conn.commit()

    """
    Populates the USERS and LISTINGS tables with default dummy data.
    """
    def populate_database(self):
        # Check if tables are already populated
        self.cursor.execute("SELECT * FROM users")
        res = self.cursor.fetchall()
        if not res: # if unpopulated
            with open(PATH + 'sample_users.csv') as csv_file:    
                csv_users = csv.reader(csv_file, delimiter=',')
                for row in csv_users:
                    insert_query = f"INSERT INTO users VALUES {tuple(row)}"
                    self.cursor.execute(insert_query)
            with open(PATH + 'production_users.csv') as csv_file:    
                csv_users = csv.reader(csv_file, delimiter=',')
                for row in csv_users:
                    insert_query = f"INSERT INTO users VALUES {tuple(row)}"
                    self.cursor.execute(insert_query)

        select_check = "SELECT * FROM listings"
        self.cursor.execute(select_check)
        res = self.cursor.fetchall()
        if not res:
            with open(PATH + 'sample_listings.csv') as csv_file:
                csv_listings = csv.reader(csv_file, delimiter=',')
                for row in csv_listings:
                    insert_query = insert_query = f"INSERT INTO listings VALUES {tuple(row)}"
                    self.cursor.execute(insert_query)
            with open(PATH + 'production_listings.csv') as csv_file:
                csv_listings = csv.reader(csv_file, delimiter=',')
                for row in csv_listings:
                    insert_query = insert_query = f"INSERT INTO listings VALUES {tuple(row)}"
                    self.cursor.execute(insert_query)

        self.conn.commit()

    def get_listings(self):
        self.cursor.execute("SELECT * FROM listings AS l LEFT JOIN (SELECT id as uid, fname, lname, phone, email FROM users) AS u ON l.user_id = u.uid LIMIT 20")
        columns = [column[0] for column in self.cursor.description]
        raw_data = self.cursor.fetchall()
        data = [dict(zip(columns, row)) for row in raw_data]
        return data

    def get_listings_by_id(self, request):
        """Schema is:
        {
            "user": w
        }
        """
        try:
            user = request["user"]
        except:
            raise KeyError("Schema for request should be {'user': id}")

        self.cursor.execute(f"SELECT * FROM listings AS l LEFT JOIN (SELECT id AS uid, fname, lname, phone, email FROM users) AS u ON l.user_id = u.uid WHERE l.user_id = '{user}'")
        columns = [column[0] for column in self.cursor.description]

        data = [dict(zip(columns, row)) for row in self.cursor.fetchall()]

        return data

    def get_listing_by_listing_id(self, request):
        """Schema is:
        {
            "listingid": x
        }
        """
        try:
            id = request["listing_id"]
        except KeyError:
            raise KeyError("Schema for request should be {'listing_id': id}")

        self.cursor.execute(f"SELECT * FROM listings AS l LEFT JOIN (SELECT id AS uid, fname, lname, phone, email FROM users) AS u ON l.user_id = u.uid WHERE l.id = {id}")
        columns = [column[0] for column in self.cursor.description]

        data = [dict(zip(columns, row)) for row in self.cursor.fetchall()]

        return data

    def modify_listing(self, request):
        """Schema is:
        listing_schema = {
            "id": "INT NOT NULL, ",
            "user_id": "INT NOT NULL, ",
            "address": "VARCHAR(1000) NOT NULL, ",
            "city": "VARCHAR(300), ",
            "province": "VARCHAR(300), ",
            "rooms": "INT, ",
            "bathrooms": "INT, ",
            "feet": "INT, ",
            "heating": "INT, ",
            "water": "INT, ",
            "hydro": "INT, ",
            "type": "VARCHAR(300), ",
            "parking": "INT, ",
            "price": "INT, ",
            "months": "INT, ",
            "comment": "VARCHAR(2000), "
        }
        """
        print("request", request)
        try:
            lid = request["id"]
            uid = request["user_id"]
        except KeyError:
            raise KeyError("Schema for request must contain field `id` and `user_id`!")
        
        existence = f"""
            SELECT * FROM listings WHERE id = {lid} AND user_id = {uid};
        """

        exists = self.cursor.execute(existence)
        if not bool(exists):
            return False
        
        pairs = ""

        for key, value in request.items():
            if key in ["id", "user_id", None]:
                continue

            if listing_types[key] == str:
                pairs += f"{key} = '{value}', "
            else:
                pairs += f"{key} = {value}, "

        update = f"""
            UPDATE listings
            SET {pairs[:-2]}
            WHERE id = {lid} AND user_id = {uid};
        """

        self.cursor.execute(update)
        self.conn.commit()

        return True

    def create_account(self, request):
        """ Schema is:
        {
            "user": w,
            "pass": x,
            "first": a,
            "last": b,
            "phone": y,
            "email": z,
        }
        """
        user = request["user"]
        email = request["email"]
        request["pass"] = hash(request["pass"])

        self.cursor.execute(f"SELECT * FROM users WHERE username='{user}'")
        if self.cursor.fetchall():
            return 0

        self.cursor.execute(f"SELECT * FROM users WHERE email='{email}'")
        if self.cursor.fetchall():
            return -1

        self.cursor.execute("SELECT id FROM users ORDER BY id DESC")
        id = int(self.cursor.fetchall()[0][0]) + 1
        # ID stores 1 + max(id), so that id's are not duplicated, even when some accs are deleted.

        q = f"INSERT INTO users VALUES {(id, *request.values())}"

        self.cursor.execute(q)
        self.conn.commit()

        return 1

    def delete_account(self, request):
        """ Schema is:
        {
            "user": w,
        }
        """

        user = list(request.values())[0]

        self.cursor.execute(f"SELECT * FROM users WHERE username='{user}'")
        if not self.cursor.fetchall():
            return 0

        q1 = f"DELETE FROM listings WHERE user_id IN (SELECT id from users WHERE username='{user}')"
        self.cursor.execute(q1)
        q2 = f"DELETE FROM users WHERE username='{user}'"
        self.cursor.execute(q2)
        self.conn.commit()

        return 1

    def create_listing(self, request):
        self.cursor.execute("SELECT id FROM listings ORDER BY id DESC")
        id = int(self.cursor.fetchall()[0][0]) + 1
        # ID stores 1 + max(id), so that id's are not duplicated, even when some listings are deleted.
        keys = tuple(request.keys())
        q = f"INSERT INTO listings ({', '.join(str(x) for x in ['id', *keys])}) VALUES {(id, *request.values())}"
        print(q)
        self.cursor.execute(q)
        self.conn.commit()

        return id

    def delete_listing(self, request):
        """ Schema is:
        {
            "id": x,
        }
        """

        id = list(request.values())[0]

        self.cursor.execute(f"SELECT * FROM listings WHERE id='{id}'")
        if not self.cursor.fetchall():
            return 0

        self.cursor.execute(f"DELETE FROM listings WHERE id='{id}'")

        self.conn.commit()

        return 1

    def login(self, request):
        """ Schema for request is:
        {
            "user_or_email": x,
            "pass": y
        }
        """

        first = request["user_or_email"]
        pwd = request["pass"]
        
        exist = self.cursor.execute(f"SELECT * FROM users WHERE username='{first}' OR email='{first}'")
        if not bool(exist):
            return (0, 0, -1)

        self.cursor.execute(f"SELECT password FROM users WHERE (username='{first}' OR email='{first}')")
        hash = self.cursor.fetchone()[0]
        correct = auth(pwd, hash)
        if not correct:
            return (1, 0, -1)

        self.cursor.execute(f"SELECT id FROM users WHERE (username='{first}' OR email='{first}')")
        user = self.cursor.fetchone()
        print("user", user)
        return (1, 1, user)
