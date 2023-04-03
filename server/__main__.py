from flask import Flask
from flask import request
from mysql.connector import Error
import mysql.connector
import pandas as pd
import sys
import json

app = Flask(__name__)
SQL = None


@app.route("/")
def home():
    return "Hello, World!"


@app.route("/corsiLaurea", methods = ['POST'])
def corsiLaurea():
    cursor = SQL.cursor()

    cursor.execute('SELECT + from corsodilaurea')
    fetch = cursor.fetchall()
    ris = json.dumps(fetch)
    cursor.close()
    return ris
    

@app.route("/iscrivi", methods = ['POST'])
def pippo():

    nome = request.args.get('nome')
    cognome = request.args.get('cognome')
    matricola = request.args.get('matricola')
    email = cognome + '.' + matricola + '@studenti.uniroma1.it'
    password = request.args.get('password')

    cursor = SQL.cursor()
    
    query = 'INSERT INTO studente (nome, cognome, matricola, email, PASSWORD) VALUES (%s, %s, %s, %s, %s)'
    data = (nome, cognome, matricola, email, password)

    cursor.execute(query, data)
    SQL.commit()
    cursor.close()
        
    return "ASD"

def SQLconnection(ip, name, psw, db):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=ip,
            user=name,
            passwd=psw,
            db=db
        )
        print("MySQL Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")

    return connection

def main():
    SQL = SQLconnection(ip='localhost', name='root', psw='root', db='app')
    app.run(debug=True)
    SQL.close()
    sys.exit()



if __name__ == "__main__":
    main()
