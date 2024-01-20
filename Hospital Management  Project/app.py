from flask import Flask, render_template, request
from flask_mysqldb import MySQL
from datetime import datetime
app = Flask(__name__)

app.config['MYSQL _HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'frankocean'
app.config['MYSQL_DB'] = 'project'

mysql = MySQL(app)

@app.route('/')
def home():
    return render_template('aaaaaahome.html')

@app.route('/rec')
def rec():
    return render_template('rec.html')

@app.route('/med')
def med():
    return render_template('med.html')

@app.route('/ser')
def ser():
    return render_template('ser.html')

@app.route('/emp')
def emp():
    return render_template('emp.html')

@app.route('/doc_input', methods=['GET', 'POST'])
def doctor_input():
    if request.method == 'POST':
        # fetch form data 
        userDetails = request.form
        doc_id = userDetails['doc_id']
        name = userDetails['name']
        special = userDetails['special']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO doctor(doctor_id, doctor_name, specialization) VALUES(%s, %s, %s)", (doc_id, name, special))
        mysql.connection.commit()
        cur.close()
        return 'success!'
    return render_template('doc_input.html')

@app.route('/doc_output')
def users():
    cur = mysql.connection.cursor()
    resultValue = cur.execute("SELECT * FROM doctor")
    if resultValue > 0:
        userDetails = cur.fetchall()
        return render_template('doc_output.html',userDetails=userDetails)

@app.route('/rec_input', methods=['GET', 'POST'])
def rec_input():
    if request.method == 'POST':
        # fetch form data 
        userDetails = request.form
        adm_id = userDetails['adm_id']
        adm_date = datetime.strptime(userDetails['adm_date'], '%Y-%m-%d').date()
        pat_name = userDetails['pat_name']
        gender = userDetails['gender']
        dob = datetime.strptime(userDetails['dob'], '%Y-%m-%d').date()
        bg = userDetails['bg']
        pay_id = userDetails['pay_id']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO patient(admission_id, admission_date, patient_name, gender, DOB, blood_group, payment_id) VALUES(%s, %s, %s, %s, %s, %s, %s)", (adm_id, adm_date, pat_name, gender, dob, bg, pay_id))
        mysql.connection.commit()
        cur.close()
        return 'success!'
    return render_template('rec_input.html')

@app.route('/rec_output')
def rec_output():
    cur = mysql.connection.cursor()
    resultValue = cur.execute("SELECT * FROM patient")
    if resultValue > 0:
        userDetails = cur.fetchall()
        return render_template('rec_output.html',userDetails=userDetails)

if __name__ == "__main__":
    app.run(debug=True)
